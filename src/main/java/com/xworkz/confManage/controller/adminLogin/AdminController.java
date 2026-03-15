package com.xworkz.confManage.controller.adminLogin;

import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import com.xworkz.confManage.exception.UserNotFoundException;
import com.xworkz.confManage.service.admin.AdminService;
import com.xworkz.confManage.service.participants.ParticipantsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    AdminService adminService;
    @Autowired
    ParticipantsService participantsService;

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
                return "AdminLoginPage";
            }

        } catch (UserNotFoundException e) {

            model.addAttribute("errorMsg1", e.getMessage());
            return "index";
        }
    }

    @GetMapping("participantsAdmin")
    public String viewParticipants(
            @RequestParam int conferenceId,
            Model model){
        List<ParticipantsEntity> list =
                participantsService.getParticipantsForAdmin(conferenceId);

        model.addAttribute("participantsList", list);

        return "viewParticipantsAdmin"; // JSP page
    }
}