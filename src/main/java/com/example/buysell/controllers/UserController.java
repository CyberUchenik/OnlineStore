    package com.example.buysell.controllers;

    import com.example.buysell.models.User;
    import com.example.buysell.services.UserService;
    import lombok.RequiredArgsConstructor;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.web.bind.annotation.*;
    import org.springframework.web.multipart.MultipartFile;

    import java.io.IOException;
    import java.security.Principal;

    @Controller
    @RequiredArgsConstructor
    public class UserController {
        private final UserService userService;

        @GetMapping("/login")
        public String login(Principal principal, Model model) {
            model.addAttribute("user", userService.getUserByPrincipal(principal));
            return "login";
        }

        @GetMapping("/profile")
        public String profile(Principal principal,
                              Model model) {
            User user = userService.getUserByPrincipal(principal);
            model.addAttribute("user", user);
            return "profile";
        }

        @GetMapping("/registration")
        public String registration(Principal principal, Model model) {
            model.addAttribute("user", userService.getUserByPrincipal(principal));
            return "registration";
        }


        @PostMapping("/registration")
        public String createUser(User user, Model model) {
            if (!userService.createUser(user)) {
                model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует");
                return "registration";
            }
            return "registration-confirmation";
        }
        @GetMapping("/edit-profile")
        public String showEditProfileForm(Principal principal, Model model) {
            User user = userService.getUserByPrincipal(principal);
            model.addAttribute("user", user);
            return "edit-profile";
        }

        @PostMapping("/update-profile")
        public String updateProfile(@ModelAttribute User updatedUser, Principal principal) {
            userService.updateUserProfile(updatedUser, principal);
            return "redirect:/profile";
        }
        @GetMapping("/user/{user}")
        public String userInfo(@PathVariable("user") User user, Model model, Principal principal) {
            model.addAttribute("user", user);
            model.addAttribute("userByPrincipal", userService.getUserByPrincipal(principal));
            model.addAttribute("products", user.getProducts());
            return "user-info";
        }
        @PostMapping("/user/change-avatar")
        public String changeUserAvatar(@RequestParam("avatar") MultipartFile avatarFile, Principal principal) throws IOException {
            userService.changeUserAvatar(avatarFile, principal);
            return "redirect:/profile";
        }
        @GetMapping("/forgot-password")
        public String displayForgotPasswordPage() {
            System.out.println("Displaying forgot password page");
            return "forgot-password";
        }

        @PostMapping("/forgot-password")
        public String processForgotPasswordForm(@RequestParam("email") String email, Model model) {
            System.out.println("Processing forgot password for email: " + email);
            userService.sendPasswordResetToken(email);
            System.out.println("Forgot password processed");
            model.addAttribute("message", "Если адрес электронной почты существует в нашей системе, на него будет отправлена ссылка для сброса пароля.");
            return "forgot-password-confirmation";
        }


        // Отображение страницы для установки нового пароля
        @GetMapping("/reset-password")
        public String displayResetPasswordPage(@RequestParam("token") String token, Model model, Principal principal) {
            boolean isTokenValid = userService.validatePasswordResetToken(token);
            if (!isTokenValid) {
                model.addAttribute("error", "Токен для сброса пароля недействителен или истек его срок.");
                return "reset-password-error"; // Отображение страницы с ошибкой, если токен недействителен
            }
            model.addAttribute("token", token);
            model.addAttribute("user", userService.getUserByPrincipal(principal));
            return "reset-password"; // Имя вашего файла .ftlh для установки нового пароля
        }

        // Обработка установки нового пароля
        @PostMapping("/reset-password")
        public String processResetPasswordForm(
                @RequestParam("token") String token,
                @RequestParam("password") String password,
                @RequestParam("confirmPassword") String confirmPassword,
                Model model)
        {
            if (!password.equals(confirmPassword)) {
                model.addAttribute("error", "Пароли не совпадают.");
                return "reset-password";
            }
            boolean isPasswordChanged = userService.changeUserPassword(token, password);
            if (!isPasswordChanged) {
                model.addAttribute("error", "Произошла ошибка при смене пароля.");
                return "reset-password";
            }

            return "reset-password-success"; // Отображение страницы с подтверждением успешной смены пароля
        }
    }
