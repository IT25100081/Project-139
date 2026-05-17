package com.group139.beautysalon.controllers;

import com.group139.beautysalon.service.interfaces.ServiceManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final ServiceManager serviceManager;

    public HomeController(ServiceManager serviceManager) {
        this.serviceManager = serviceManager;
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("services", serviceManager.getAllServices());
        return "index";
    }
}
