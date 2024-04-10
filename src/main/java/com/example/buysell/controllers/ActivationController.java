package com.example.buysell.controllers;

import com.example.buysell.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ActivationController {

    private final UserService userService;

    @Autowired
    public ActivationController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        System.out.println("Activating user with code: " + code); // Для отладки
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            System.out.println("Activation successful."); // Для отладки
            return "activation-success";
        } else {
            System.out.println("Activation failed."); // Для отладки
            model.addAttribute("message", "Activation code is not found or it's already activated!");
            return "redirect:/";
        }
    }

}
