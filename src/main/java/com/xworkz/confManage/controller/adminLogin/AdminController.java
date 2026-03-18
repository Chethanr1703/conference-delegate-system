package com.xworkz.confManage.controller.adminLogin;

import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import com.xworkz.confManage.exception.UserNotFoundException;
import com.xworkz.confManage.service.admin.AdminService;
import com.xworkz.confManage.service.participants.ParticipantsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    AdminService adminService;
    @Autowired
    ParticipantsService participantsService;

    @GetMapping("/adminLogin")
    public String loadAdminLoginPage() {
        return "AdminLoginPage";   // JSP name
    }

    @PostMapping("/login")
    public String getSignIn(@RequestParam String email,
                            @RequestParam String password,
                            Model model, HttpServletRequest request) {

        try {

            boolean isLogin = adminService.adminLogin(email, password);

            if (isLogin) {
                HttpSession session = request.getSession(true);
                session.setAttribute("admin", email);

                System.out.println("Admin Logged In | Session ID: " + session.getId());

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
            Model model,HttpSession session){
        if (session == null || session.getAttribute("admin") == null) {
            return "redirect:/adminLogin";
        }

        List<ParticipantsEntity> list =
                participantsService.getParticipantsForAdmin(conferenceId);

        model.addAttribute("participantsList", list);

        return "viewParticipantsAdmin"; // JSP page
    }

    @GetMapping("/logoutAdmin")
    public String logout(HttpServletRequest request) {


        HttpSession session1 = request.getSession(false); // get existing session

        if (session1 != null) {
            System.out.println("Session ID before logout: " + session1.getId());

            session1.invalidate();  // 🔥 destroy session completely
        }

        return "redirect:/adminLogin";
    }
}