package com.xworkz.confManage.controller.onlineParticipants;

import com.xworkz.confManage.dto.participantsdto.ParticipantsDTO;
import com.xworkz.confManage.service.participants.ParticipantsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class OnlineParticipantsController {

    @Autowired
    ParticipantsService participantsService;

    @GetMapping("onlineParticipants")
    public  String loadOnlineRegisterForm(){
        return "onlineParticipants";
    }



    @PostMapping("onlineParticipantRegister")
    public String registerParticipant(
            @Valid ParticipantsDTO dto,
            BindingResult bindingResult,
            Model model) {
        System.out.println(dto.getConferenceId());

        if (bindingResult.hasErrors()) {

            bindingResult.getAllErrors().forEach(error ->
                    System.out.println(error.getDefaultMessage())
            );
            model.addAttribute("errorMsg", "Please fill all fields correctly ");
            return "onlineParticipants";
        }

        boolean saved = participantsService.registerOnlineParticipant(dto);

        if (saved) {
            model.addAttribute("successMsg", "Registration Successful ");
        } else {
            model.addAttribute("errorMsg", "Registration Failed ");
        }

        return "onlineParticipants";
    }
}
