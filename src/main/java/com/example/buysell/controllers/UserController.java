    package com.example.buysell.controllers;

    import com.example.buysell.models.User;
    import com.example.buysell.services.UserService;
    import lombok.RequiredArgsConstructor;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.PathVariable;
    import org.springframework.web.bind.annotation.PostMapping;
    import org.springframework.web.bind.annotation.RequestParam;
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

    }
