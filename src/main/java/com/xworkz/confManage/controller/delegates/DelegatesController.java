package com.xworkz.confManage.controller.delegates;

import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.exception.UserNotFoundException;
import com.xworkz.confManage.service.conference.ConferenceService;
import com.xworkz.confManage.service.delegate.DelegateService;
import com.xworkz.confManage.service.delegatedashboard.DelegateDashboardService;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DelegatesController {

    @Autowired
    DelegateService delegateService;

    @Autowired
    ConferenceService conferenceService;

    @Autowired
    DelegateDashboardService delegateDashboardService;

    @GetMapping("delegateLogin")
    public String getLoginPage() {
        return "delegateLogin";
    }

    @GetMapping("delegatesRegister")
    public String getStudentRegister() {
        return "delegatesRegistrationForm";
    }

    @PostMapping("delegateLogin")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        Model model, HttpSession httpSession) {
        try {

            DelegateUserEntity delegateLogin = delegateService.delegateLogin(email, password);

            if (delegateLogin!=null) {
                httpSession.setAttribute("delegate",delegateLogin);
                return "redirect:/delegatesPage";

            } else {
                model.addAttribute("errorMsg1", "Invalid email or password");
                return "delegateLogin";
            }

        } catch (UserNotFoundException e) {

            model.addAttribute("errorMsg1", e.getMessage());
            return "delegateLogin";
        }

    }
    //--------------------------------------DashBoard Code--------------------------------

    @GetMapping("/delegatesPage")
    public String delegatesPage(HttpSession session, Model model) {

        DelegateUserEntity delegate =
                (DelegateUserEntity) session.getAttribute("delegate");
        if (delegate == null) {
            return "delegateLogin";
        }
        String email = delegate.getEmail();
        List<ConferenceEntity> conferences =
                delegateDashboardService.getConferencesByEmail(email);

        model.addAttribute("conferenceList", conferences);

        return "delegatesPage";
    }

    @PostMapping("/respondConference")
    public String respondConference(
            @RequestParam int id,
            @RequestParam(required = false) String response , Model model){

        boolean updated =
                delegateDashboardService.respondConference(id,response);


        if(updated){
            model.addAttribute("showAccepted", false);
            model.addAttribute("showAllConference", false);

            return "redirect:/delegatesPage";
        }
        return "delegatePage";
    }


    @GetMapping("/acceptedConferences")
    public String getAcceptedConferences(HttpSession session,Model model){
        DelegateUserEntity delegate =
                (DelegateUserEntity) session.getAttribute("delegate");
        if (delegate == null) {
            return "delegateLogin";
        }
        String email = delegate.getEmail();
        List<ConferenceEntity> conferences =
                delegateDashboardService.getAcceptedConferences(email);
        model.addAttribute("showAccepted", true);
        model.addAttribute("acceptedConferenceList", conferences);
        return "delegatesPage";
    }

    // to display all the conference to tpo/hr
    @GetMapping("/allConference")
    public String loadAllConference(HttpSession session, Model model) {

        DelegateUserEntity delegate =
                (DelegateUserEntity) session.getAttribute("delegate");
        if (delegate == null) {
            return "delegateLogin";
        }
        String email = delegate.getEmail();
        List<ConferenceEntity> conferences =
                delegateDashboardService.getAllConferencesByEmail(email);

        model.addAttribute("allConferenceList", conferences);
        model.addAttribute("showAllConference", true);


        return "delegatesPage";
    }
    @GetMapping("loadParticipantsPage")
    public  String  getParticipantsPage(){
        return "ParticipatesInvitee";
    }

    //------------implementing Bulk Submission using Excel sheet


    @GetMapping("/downloadTemplate")
    public void downloadTemplate(HttpServletResponse response) throws Exception {

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Participants");

        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("slno");
        header.createCell(1).setCellValue("name");
        header.createCell(2).setCellValue("email");
        header.createCell(3).setCellValue("mobile");
        header.createCell(4).setCellValue("organization");
        header.createCell(5).setCellValue("attending");

        response.setContentType("application/octet-stream");

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=participants_template.xlsx"
        );

        workbook.write(response.getOutputStream());
        workbook.close();
    }

    //------ reading Excel File//
    @PostMapping("/delegate/uploadParticipants")
    public String uploadParticipants(
            @RequestParam("file") MultipartFile file,
            @RequestParam int conferenceId,
            HttpSession session){

        DelegateUserEntity delegate =
                (DelegateUserEntity) session.getAttribute("user");

        participantService.processExcel(
                file,
                conferenceId,
                delegate.getId()
        );

        return "redirect:/delegate/dashboard";
    }
}
