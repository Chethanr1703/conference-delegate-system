package com.xworkz.confManage.controller.delegates;

import com.xworkz.confManage.exception.UserNotFoundException;
import com.xworkz.confManage.service.delegate.DelegateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DelegatesController {

    @Autowired
    DelegateService delegateService;

    @GetMapping("delegateLogin")
    public String getLoginPage(){
        return "delegateLogin";
    }

    @GetMapping("delegatesRegister")
    public String getStudentRegister(){
        return "delegatesRegistrationForm";
    }

    @PostMapping("delegateLogin")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        Model model){
        try {

            boolean isLogin = delegateService.delegateLogin(email, password);

            if (isLogin) {
                return "delegatesPage";
            } else {
                model.addAttribute("errorMsg1", "Invalid email or password");
                return "delegateLogin";
            }

        } catch (UserNotFoundException e) {

            model.addAttribute("errorMsg1", e.getMessage());
            return "index";
        }

    }
}
