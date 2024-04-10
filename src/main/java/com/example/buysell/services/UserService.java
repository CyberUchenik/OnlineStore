package com.example.buysell.services;

import com.example.buysell.models.Image;
import com.example.buysell.models.PasswordResetToken;
import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.repositories.ImageRepository;
import com.example.buysell.repositories.PasswordResetTokenRepository;
import com.example.buysell.repositories.UserRepository;
import com.example.buysell.utils.ImageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.io.IOException;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;
import java.util.UUID;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordResetTokenRepository tokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final ImageRepository imageRepository;
    private final EmailService emailService;

    @Transactional
    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) {
            return false;
        }
        user.setActivationCode(UUID.randomUUID().toString());
        user.setActive(false); // Изменено на false для нового пользователя
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        log.info("Saving new User with email: {}", email);
        userRepository.save(user);
        log.info("Saving new User with email: {} and activation code: {}", email, user.getActivationCode());

        userRepository.save(user);
        // Отправка активационного кода на email пользователя
        String message = String.format(
                "Hello, %s! \n" +
                        "Welcome to our site. Please, visit next link to activate your account: " +
                        "http://localhost:8080/activate/%s",
                user.getEmail(),
                user.getActivationCode()
        );
        emailService.send(user.getEmail(), "Activation code", message);

        return true;
    }
    public void createPasswordResetTokenForUser(final User user, final String token) {
        final PasswordResetToken myToken = new PasswordResetToken();
        myToken.setUser(user);
        myToken.setToken(token);
        // Установите срок действия токена здесь, если необходимо
        tokenRepository.save(myToken);
    }

    public void sendPasswordResetToken(final String email) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            String token = UUID.randomUUID().toString();
            createPasswordResetTokenForUser(user, token);
            // Предположим, что метод sendSimpleMessage теперь является частью emailService
            emailService.send(email, "Сброс пароля", "Чтобы сбросить пароль, перейдите по ссылке: http://localhost:8080/reset-password?token=" + token);

        }
    }
    public boolean validatePasswordResetToken(String token) {
        PasswordResetToken passToken = tokenRepository.findByToken(token);
        return passToken != null;
    }

    // Метод для изменения пароля пользователя
    @Transactional
    public boolean changeUserPassword(String token, String newPassword) {
        PasswordResetToken passToken = tokenRepository.findByToken(token);
        if (passToken == null) {
            return false;
        }
        User user = passToken.getUser();
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        userRepository.save(user);
        // После успешного изменения пароля, токен сброса должен быть удален или инвалидирован
        tokenRepository.delete(passToken);
        return true;
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);

        if (user == null) {
            return false; // Пользователь не найден или код не существует
        }

        user.setActivationCode(null); // Удаляем код активации, так как он уже использован
        user.setActive(true); // Активируем пользователя
        userRepository.save(user); // Сохраняем изменения в базе данных

        return true; // Успешная активация
    }

    // Остальные методы не изменились
    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(!user.isActive());
            log.info((user.isActive() ? "Unban" : "Ban") + " user with id = {}; email: {}", user.getId(), user.getEmail());
            userRepository.save(user);
        }
    }

    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    @Transactional
    public void changeUserAvatar(MultipartFile avatarFile, Principal principal) throws IOException {
        User user = userRepository.findByEmail(principal.getName());
        if (user != null && !avatarFile.isEmpty()) {
            Image oldAvatar = user.getAvatar();
            if (oldAvatar != null) {
                imageRepository.delete(oldAvatar);
            }
            Image newAvatar = ImageUtils.toImageEntity(avatarFile);
            user.setAvatar(newAvatar);
            userRepository.save(user);
        }
    }

    public void updateUserRoles(Long userId, String[] roles) {
        User user = userRepository.findById(userId).orElseThrow(() ->
                new EntityNotFoundException("Пользователь с ID " + userId + " не найден"));
        Set<Role> newRoles = (roles != null) ? Arrays.stream(roles)
                .map(Role::valueOf)
                .collect(Collectors.toSet()) : Collections.emptySet();
        user.getRoles().clear();
        user.getRoles().addAll(newRoles);
        userRepository.save(user);
    }
}
