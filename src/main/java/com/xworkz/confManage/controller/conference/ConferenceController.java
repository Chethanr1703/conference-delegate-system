package com.xworkz.confManage.controller.conference;

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
//
//    @PostMapping("conferenceRegister")
//    public ModelAndView registerConference(
//            @Valid ConferenceDTO conferenceDTO,
//            BindingResult bindingResult,
//            ModelAndView mv) {
//
//        mv.addObject("dto", conferenceDTO);
//
//
//        if (bindingResult.hasErrors()) {
//
//            if (bindingResult.hasFieldErrors("hostName")) {
//                mv.addObject("hostNameError",
//                        bindingResult.getFieldError("hostName").getDefaultMessage());
//            }
//
//            if (bindingResult.hasFieldErrors("email")) {
//                mv.addObject("emailError",
//                        bindingResult.getFieldError("email").getDefaultMessage());
//            }
//
//            if (bindingResult.hasFieldErrors("conferenceTopic")) {
//                mv.addObject("topicError",
//                        bindingResult.getFieldError("conferenceTopic").getDefaultMessage());
//            }
//
//            if (bindingResult.hasFieldErrors("targetedAudience")) {
//                mv.addObject("audienceError",
//                        bindingResult.getFieldError("targetedAudience").getDefaultMessage());
//            }
//
//            if (bindingResult.hasFieldErrors("date")) {
//                mv.addObject("dateError",
//                        bindingResult.getFieldError("date").getDefaultMessage());
//            }
//
//            if (bindingResult.hasFieldErrors("time")) {
//                mv.addObject("timeError",
//                        bindingResult.getFieldError("time").getDefaultMessage());
//            }
//
////            mv.setViewName("index");
////            return mv;
//        }
//
//        boolean isSaved = conferenceService.saveConference(conferenceDTO);
//
//        if (isSaved) {
//            mv.addObject("successMsg", "Conference submitted successfully");
//            mv.addObject("dto", new ConferenceDTO());
//        } else {
//            mv.addObject("errorMsg", "Something went wrong");
//        }
//
//        mv.setViewName("index");
//        return mv;
//    }


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

        boolean sent = conferenceService.sendToTPO(id);

        model.addAttribute("msg", sent ? "Mail Sent to TPO" : "Failed");

        return "redirect:/admin/dashboard";
    }

//    @GetMapping({"http://localhost:8080/conference/", "conference/"})
//    public ModelAndView loadHome(ModelAndView modelAndView) {
//        System.out.println("hi");
//        System.out.println(conferenceService.getSentConferences());
//        List<ConferenceDTO> upcoming =
//                conferenceService.getSentConferences();
//
//       modelAndView.addObject ("upcomingList", upcoming);
//       modelAndView.setViewName("index");
//
//        return modelAndView;
//    }
}