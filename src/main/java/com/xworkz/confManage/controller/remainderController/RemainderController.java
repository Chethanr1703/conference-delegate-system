package com.xworkz.confManage.controller.remainderController;

import com.xworkz.confManage.service.conference.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RemainderController {

    @Autowired
    ConferenceService conferenceService;
    @PostMapping("/sendReminder")
    public String sendReminder(@RequestParam int conferenceId,
                               RedirectAttributes redirectAttributes) {

        boolean sent = conferenceService.sendReminderToParticipants(conferenceId);

        if (sent) {
            redirectAttributes.addFlashAttribute("successMsg", "Reminder sent successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Failed to send reminder!");
        }

        return "redirect:/admin/dashboard?filter=sent";
    }
}
