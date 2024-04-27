package com.example.buysell;


import com.example.buysell.models.PasswordResetToken;
import com.example.buysell.models.User;
import com.example.buysell.repositories.UserRepository;
import com.example.buysell.repositories.PasswordResetTokenRepository;
import com.example.buysell.services.EmailService;
import com.example.buysell.services.UserService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private PasswordResetTokenRepository tokenRepository;
    @Mock
    private PasswordEncoder passwordEncoder;
    @Mock
    private EmailService emailService;

    @InjectMocks
    private UserService userService;

    @Test
    void createUser_ShouldFail_WhenEmailAlreadyExists() {
        User user = new User();
        user.setEmail("test@example.com");
        user.setPassword("password123");

        when(userRepository.findByEmail("test@example.com")).thenReturn(user);

        assertFalse(userService.createUser(user));

        verify(userRepository, never()).save(any(User.class));
    }

    @Test
    void activateUser_ShouldActivateUser_WhenCorrectCodeProvided() {
        User user = new User();
        user.setActivationCode("correctCode");

        when(userRepository.findByActivationCode("correctCode")).thenReturn(user);

        assertTrue(userService.activateUser("correctCode"));

        verify(userRepository).save(user);
        assertNull(user.getActivationCode());
        assertTrue(user.isActive());
    }

    @Test
    void activateUser_ShouldFail_WhenWrongCodeProvided() {
        when(userRepository.findByActivationCode("wrongCode")).thenReturn(null);

        assertFalse(userService.activateUser("wrongCode"));

        verify(userRepository, never()).save(any(User.class));
    }

    @Test
    void changeUserPassword_ShouldChangePassword_WhenCorrectTokenProvided() {
        User user = new User();
        PasswordResetToken token = new PasswordResetToken();
        token.setUser(user);
        token.setToken("validToken");

        when(tokenRepository.findByToken("validToken")).thenReturn(token);
        when(passwordEncoder.encode("newPassword")).thenReturn("encodedNewPassword");

        assertTrue(userService.changeUserPassword("validToken", "newPassword"));

        verify(userRepository).save(user);
        assertEquals("encodedNewPassword", user.getPassword());
        verify(tokenRepository).delete(token);
    }

    @Test
    void changeUserPassword_ShouldFail_WhenInvalidTokenProvided() {
        when(tokenRepository.findByToken("invalidToken")).thenReturn(null);

        assertFalse(userService.changeUserPassword("invalidToken", "newPassword"));

        verify(userRepository, never()).save(any(User.class));
        verify(tokenRepository, never()).delete(any(PasswordResetToken.class));
    }
}

