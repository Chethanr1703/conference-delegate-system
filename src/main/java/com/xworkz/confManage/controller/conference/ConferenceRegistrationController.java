package com.xworkz.confManage.controller.conference;

import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.service.conference.ConferenceService;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

@Controller
public class ConferenceRegistrationController {

    @Autowired
    ConferenceService conferenceService;
    @GetMapping("registerConference")
    public String loadRegisterPage(){
        return "RegisterConference";
    }

    @GetMapping("backToIndex")
    public String backToIndex(){
        return "index";
    }

    @PostMapping("conferenceRegister")
    public ModelAndView registerConference(
            @Valid ConferenceDTO conferenceDTO,
            BindingResult bindingResult,
            @RequestParam("poster") MultipartFile poster,
            @RequestParam("delegateFile") MultipartFile delegateFile,
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

        boolean isSaved = conferenceService.saveConference(
                conferenceDTO, poster, delegateFile);

        if (isSaved) {
            mv.addObject("successMsg", "Conference submitted successfully");
            mv.addObject("dto", new ConferenceDTO());
        } else {
            mv.addObject("errorMsg", "Something went wrong");
        }

        mv.setViewName("RegisterConference");
        return mv;
    }
    // downloading the Excel file for delegate email

    @GetMapping("/downloadDelegateTemplate")
    public void downloadTemplate(HttpServletResponse response) throws Exception {

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Delegates");

        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("Delegates Email");

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=delegates.xlsx");

        workbook.write(response.getOutputStream());
        workbook.close();
    }


}
