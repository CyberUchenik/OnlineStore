package com.example.buysell.services;

import com.example.buysell.models.Image;
import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.repositories.ImageRepository;
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

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ImageRepository imageRepository;

    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        log.info("Saving new User with email: {}", email);
        userRepository.save(user);
        return true;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
                log.info("Ban user with id = {}; email: {}", user.getId(), user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unban user with id = {}; email: {}", user.getId(), user.getEmail());
            }
        }
        userRepository.save(user);
    }


    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
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

    @Transactional()
    public void changeUserAvatar(MultipartFile avatarFile, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        try {
            if(user != null && !avatarFile.isEmpty()){
                Long oldAvatarId = null;
                //Проверяем, есть ли у пользователя текущий аватар
                Image oldAvatar = user.getAvatar();
                if(oldAvatar!=null){
                    imageRepository.delete(oldAvatar);
    //                oldAvatarId = oldAvatar.getId();
    //                user.setAvatar(null);
    //                userRepository.save(user);
                }
                //Создаем новый объект Image с данными нового аватара
                Image newAvatar = ImageUtils.toImageEntity(avatarFile);
                user.setAvatar(newAvatar);
                userRepository.save(user);
            }
        } catch (IOException e) {
            log.info("Что то пошло не так при загрузке файла, кратко: IOException словил братишка");
            throw new RuntimeException(e);
        }
    }

    public void updateUserRoles(Long userId, String[] roles) {
        User user = userRepository.findById(userId).orElse(null);
        if(user!=null){
            Set<Role> newRoles = (roles!=null)? Arrays.stream(roles)
                    .map(Role::valueOf)
                    .collect(Collectors.toSet()) : Collections.emptySet();

            user.getRoles().clear();
            user.getRoles().addAll(newRoles);
            userRepository.save(user);
        }else {
            log.info("Пользователь с ID " + userId + "не найден");
            throw new EntityNotFoundException("Пользователь с ID " + userId + "не найден");

        }
    }
}
