package com.xworkz.confManage.controller.adminLogin;

import com.xworkz.confManage.exception.UserNotFoundException;
import com.xworkz.confManage.service.admin.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    AdminService adminService;

    @PostMapping("/login")
    public String getSignIn(@RequestParam String email,
                            @RequestParam String password,
                            Model model) {

        try {

            boolean isLogin = adminService.adminLogin(email, password);

            if (isLogin) {
                return "redirect:/admin/dashboard";
            } else {
                model.addAttribute("errorMsg1", "Invalid email or password");
                return "index";
            }

        } catch (UserNotFoundException e) {

            model.addAttribute("errorMsg1", e.getMessage());
            return "index";
        }
    }
}