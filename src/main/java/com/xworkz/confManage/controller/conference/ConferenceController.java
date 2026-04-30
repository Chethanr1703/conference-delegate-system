package com.xworkz.confManage.controller.conference;

import com.xworkz.confManage.dto.Response.ConferenceResponseDTO;
import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.service.conference.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
public class ConferenceController {

    @Autowired
    ConferenceService conferenceService;


    @GetMapping("/admin/dashboard")
    public String loadDashboard(
            @RequestParam(required = false, defaultValue = "all") String filter,
            Model model, HttpSession session) {



        if (filter.equals("all")) {
            if (session == null || session.getAttribute("admin") == null) {
                return "redirect:/adminLogin";
            }

            model.addAttribute("conferenceList",
                    conferenceService.getAllConferences());

            model.addAttribute("showAll", true);
        }

        else if (filter.equals("pending")) {
            if (session == null || session.getAttribute("admin") == null) {
                return "redirect:/adminLogin";
            }

            model.addAttribute("conferenceList",
                    conferenceService.getUnApprovedConferences());

            model.addAttribute("showPending", true);
        }

        else if (filter.equals("approved")) {
            if (session == null || session.getAttribute("admin") == null) {
                return "redirect:/adminLogin";
            }

            model.addAttribute("conferenceList",
                    conferenceService.getApprovedConferences());

            model.addAttribute("showApproved", true);
        }

        else if (filter.equals("sent")) {
            if (session == null || session.getAttribute("admin") == null) {
                return "redirect:/adminLogin";
            }

            model.addAttribute("conferenceList",
                    conferenceService.getSentConferences());

            model.addAttribute("showSent", true);
        }

        return "AdminHome";
    }

    @PostMapping("/admin/approve")
    public String approveConference(@RequestParam int id,HttpSession session) {
        if (session == null || session.getAttribute("admin") == null) {
            return "redirect:/adminLogin";
        }
        boolean isApproved = conferenceService.approveConference(id);
        System.out.println(isApproved);

        return "redirect:/admin/dashboard";
    }


    @PostMapping("/admin/sendToDelegates")
    public String sendToDelegates(@RequestParam int id, Model model,HttpSession  session) {

        if (session == null || session.getAttribute("admin") == null) {
            return "redirect:/adminLogin";
        }
        boolean sent = false;
        try {

            sent = conferenceService.sendToTPO(id);
        } catch (Exception e) {
            System.out.println("Email failed but continuing...");
        }

        model.addAttribute("msg", sent ? "Mail Sent" : "Mail Failed");
        return "redirect:/admin/dashboard";
    }


    @GetMapping(value = "/api/upcoming", produces = "application/json")
    @ResponseBody
    public List<ConferenceResponseDTO> loadHome() {
        List<ConferenceDTO> upcoming = conferenceService.getSentConferences();

        return upcoming.stream().map(conf -> new ConferenceResponseDTO(
                conf.getId(),
                conf.getHostName(),
                conf.getEmail(),
                conf.getConferenceTopic(),
                conf.getTargetedAudience(),
                conf.getDate() != null ? conf.getDate().toString() : "",
                conf.getTime(),
                conf.isActive(),
                conf.isEmailSent()
        )).collect(java.util.stream.Collectors.toList());
    }
}