package com.xworkz.confManage.controller.conference;

import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.service.conference.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;


@Controller

public class ConferenceController {

    @Autowired
    ConferenceService conferenceService;

    @PostMapping("conferenceRegister")
    public ModelAndView registerConference(
            @Valid ConferenceDTO conferenceDTO,
            BindingResult bindingResult,
            ModelAndView mv) {

        mv.addObject("dto", conferenceDTO);


        if (bindingResult.hasErrors()) {

            if (bindingResult.hasFieldErrors("hostName")) {
                mv.addObject("hostNameError",
                        bindingResult.getFieldError("hostName").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("email")) {
                mv.addObject("emailError",
                        bindingResult.getFieldError("email").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("conferenceTopic")) {
                mv.addObject("topicError",
                        bindingResult.getFieldError("conferenceTopic").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("targetedAudience")) {
                mv.addObject("audienceError",
                        bindingResult.getFieldError("targetedAudience").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("date")) {
                mv.addObject("dateError",
                        bindingResult.getFieldError("date").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("time")) {
                mv.addObject("timeError",
                        bindingResult.getFieldError("time").getDefaultMessage());
            }

//            mv.setViewName("index");
//            return mv;
        }

        boolean isSaved = conferenceService.saveConference(conferenceDTO);

        if (isSaved) {
            mv.addObject("successMsg", "Conference submitted successfully");
            mv.addObject("dto", new ConferenceDTO());
        } else {
            mv.addObject("errorMsg", "Something went wrong");
        }

        mv.setViewName("index");
        return mv;
    }


    @GetMapping("/admin/dashboard")
    public String loadDashboard(Model model) {

        model.addAttribute("pendingList",
                conferenceService.getUnApprovedConferences());

        model.addAttribute("approvedList",
                conferenceService.getApprovedConferences());

        model.addAttribute("sentList",
                conferenceService.getSentConferences());

        return "AdminHome";   // JSP page name
    }


    @PostMapping("/admin/approve")
    public String approveConference(@RequestParam int id) {
        boolean isApproved = conferenceService.approveConference(id);
        System.out.println(isApproved);

        return "redirect:/admin/dashboard";
    }


    @PostMapping("/admin/sendToDelegates")
    public String sendToDelegates(@RequestParam int id, Model model) {

        boolean sent = conferenceService.sendToTPO(id);

        model.addAttribute("msg", sent ? "Mail Sent to TPO" : "Failed");

        return "redirect:/admin/dashboard";
    }

    @GetMapping({"", "/"})
    public String loadHome(Model model) {
        System.out.println(conferenceService.getSentConferences().size());

        model.addAttribute("upcomingList",
                conferenceService.getSentConferences());

        return "index";
    }
}