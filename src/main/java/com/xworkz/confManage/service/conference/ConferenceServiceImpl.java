package com.xworkz.confManage.service.conference;

import com.xworkz.confManage.dao.conference.ConferenceDAO;
import com.xworkz.confManage.dao.delegateDashBoard.DelegateDashboardDAO;
import com.xworkz.confManage.dao.delegates.DelegateDAO;
import com.xworkz.confManage.dao.participants.ParticipantsDAO;
import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import com.xworkz.confManage.utils.EmailService;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class ConferenceServiceImpl implements ConferenceService {

    @Autowired
    ConferenceDAO conferenceDAO;

    @Autowired
    EmailService emailService;

    @Autowired
    DelegateDashboardDAO delegateDashboard;

    @Autowired
    ParticipantsDAO participantsDAO;

    @Override
    public boolean saveConference(ConferenceDTO dto,
                                  MultipartFile poster,
                                  MultipartFile delegateFile) {

        boolean isValid = true;

        // ========= BASIC VALIDATIONS =========

        if (dto == null) {
            isValid = false;
        }

        if (dto.getHostName() == null ||
                dto.getHostName().trim().isEmpty()) {
            isValid = false;
        }

        if (dto.getEmail() == null ||
                !dto.getEmail().contains("@")) {
            isValid = false;
        }

        if (dto.getConferenceTopic() == null ||
                dto.getConferenceTopic().trim().length() < 5) {
            isValid = false;
        }

        if (dto.getTargetedAudience() == null ||
                dto.getTargetedAudience().trim().isEmpty()) {
            isValid = false;
        }

        if (dto.getDate() == null ||
                dto.getDate().isBefore(LocalDate.now())) {
            isValid = false;
        }

        if (dto.getTime() == null) {
            isValid = false;
        }

        // ========= DELEGATE VALIDATION =========

        boolean hasSingleEmail =
                dto.getDelegatesEmail() != null &&
                        !dto.getDelegatesEmail().trim().isEmpty();

        boolean hasExcel =
                delegateFile != null &&
                        !delegateFile.isEmpty();

        //  both filled → invalid
        if (hasSingleEmail && hasExcel) {
            isValid = false;
        }

        //  none filled → invalid
        if (!hasSingleEmail && !hasExcel) {
            isValid = false;
        }

        // ========= PROCESS =========

        if (isValid) {

            boolean isAvailable = conferenceDAO
                    .checkEmailAndConference(dto.getEmail(), dto.getConferenceTopic());

            if (!isAvailable) {
                return false;
            }

            try {

                ConferenceEntity entity = new ConferenceEntity();

                BeanUtils.copyProperties(dto, entity);

                // ========= IMAGE SAVE =========
                if (poster != null && !poster.isEmpty()) {
                    entity.setPoster(poster.getBytes());
                }

                // ========= EMAIL PROCESS =========
                String finalEmails = dto.getDelegatesEmail();

                if (hasExcel) {

                    List<String> excelEmails = readEmailsFromExcel(delegateFile);

                    if (!excelEmails.isEmpty()) {
                        finalEmails = String.join(",", excelEmails);
                    }
                }

                entity.setDelegatesEmail(finalEmails);

                entity.setActive(false);
                entity.setEmailSent(false);

                boolean isSaved = conferenceDAO.save(entity);

                return isSaved;

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

        return false;
    }

    private List<String> readEmailsFromExcel(MultipartFile file) {

        List<String> emails = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {

            Sheet sheet = workbook.getSheetAt(0);

            for (Row row : sheet) {

                if (row.getRowNum() == 0) {
                    continue;
                }

                Cell cell = row.getCell(0); // first column

                if (cell != null) {

                    String email = cell.getStringCellValue();

                    if (email != null && !email.trim().isEmpty()) {
                        emails.add(email.trim());
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return emails;
    }


    @Override
    public List<ConferenceDTO> getUnApprovedConferences() {

        List<ConferenceDTO> conferenceDTOS = new ArrayList<>();

        List<ConferenceEntity> conferenceEntities = conferenceDAO.getUnApprovedConferences();
        if (conferenceEntities!=null){
            for (ConferenceEntity conference:conferenceEntities){
                ConferenceDTO conferenceDTO = new ConferenceDTO();
                BeanUtils.copyProperties(conference,conferenceDTO);
                conferenceDTOS.add(conferenceDTO);
            }
            return conferenceDTOS;

        }
        return Collections.emptyList();
    }

    @Override
    public List<ConferenceDTO> getApprovedConferences() {
        List<ConferenceDTO> conferenceDTOS = new ArrayList<>();

        List<ConferenceEntity> conferenceEntities = conferenceDAO.getApprovedConferences();
        if (conferenceEntities!=null){
            for (ConferenceEntity conference:conferenceEntities){
                ConferenceDTO conferenceDTO = new ConferenceDTO();
                BeanUtils.copyProperties(conference,conferenceDTO);
                conferenceDTOS.add(conferenceDTO);
            }
            return conferenceDTOS;

        }
        return Collections.emptyList();
    }

    @Override
    public boolean approveConference(int id) {
        if(id>0){
            boolean isApproved =conferenceDAO.findConferenceToApprove(id);
            return isApproved;
        }
        return false;
    }

    @Autowired
    private DelegateDAO delegateDAO;

    @Override
    public boolean sendToTPO(int confId) {

        ConferenceEntity conf = conferenceDAO.findById(confId);

        if (conf == null) return false;

        String emails = conf.getDelegatesEmail();

        if (emails == null || emails.isEmpty()) return false;

        String[] emailList = emails.split(",");

        String role ;
        if( conf.getTargetedAudience().equalsIgnoreCase("students")){
            role="TPO";
        } else if (conf.getTargetedAudience().equalsIgnoreCase("employees")) {
            role="HR";
        } else {
            role="OTHERS";
        }

        String link = "192.168.144.125:8080/conference/delegatesRegister?confId=" + confId;

        String subject = "Conference Notification & Login Details";

        for (String email : emailList) {

            email = email.trim();

            DelegateUserEntity user = delegateDAO.findByEmail(email);

            String password;

            if (user == null) {


                user = new DelegateUserEntity();
                user.setEmail(email);

                password = generatePassword(email);
                user.setPassword(password);
                user.setRole(role);

                delegateDAO.save(user);

            } else {
                password = user.getPassword();
            }


            String body =
                    "<div style='font-family:Segoe UI,Arial,sans-serif;background:#f4f7fb;padding:20px;'>"

                            + "<div style='max-width:650px;margin:auto;background:#ffffff;border-radius:12px;"
                            + "overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,0.1);'>"

                            /* HEADER */
                            + "<div style='background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);"
                            + "color:white;padding:20px;text-align:center;'>"
                            + "<h2 style='margin:0;'>Conference Invitation</h2>"
                            + "<p style='margin:5px 0 0;'>CRDMS Portal</p>"
                            + "</div>"

                            /* POSTER IMAGE */
                            + "<div style='text-align:center;background:#eef3f8;padding:15px;'>"
                            + "<img src='cid:posterImage' style='max-width:100%;border-radius:10px;'/>"
                            + "</div>"

                            /* BODY */
                            + "<div style='padding:25px;'>"

                            + "<h3 style='color:#2c5364;margin-bottom:10px;'>"
                            + conf.getConferenceTopic()
                            + "</h3>"

                            + "<p style='color:#555;'>You are invited to participate in the following conference.</p>"

                            /* DETAILS BOX */
                            + "<div style='background:#f8f9fa;padding:15px;border-radius:10px;margin:15px 0;'>"
                            + "<p><b>Date:</b> " + conf.getDate() + "</p>"
                            + "<p><b>Time:</b> " + conf.getTime() + "</p>"
                            + "</div>"

                            /* LOGIN BOX */
                            + "<div style='background:#eef3f8;padding:15px;border-radius:10px;margin:15px 0;'>"
                            + "<h4 style='margin-top:0;color:#203a43;'>Your Login Credentials</h4>"
                            + "<p><b>Email:</b> " + email + "</p>"
                            + "<p><b>Password:</b> " + password + "</p>"
                            + "</div>"

                            /* BUTTONS */
                            + "<div style='text-align:center;margin-top:20px;'>"

                            + "<a href='http://192.168.144.125:8080/conference/delegateLogin' "
                            + "style='display:inline-block;background:#2c5364;color:white;padding:12px 20px;"
                            + "text-decoration:none;border-radius:25px;margin-right:10px;'>"
                            + "Login Now</a>"

                            + "</div>"

                            /* FOOTER */
                            + "<div style='background:#0f2027;color:white;text-align:center;padding:15px;'>"
                            + "<p style='margin:0;'>© 2026 CRDMS Conference System</p>"
                            + "<small>Automated Email - Do Not Reply</small>"
                            + "</div>"

                            + "</div>"
                            + "</div>";

            emailService.sendHtmlMail(email, subject, body,conf);
        }

        conf.setEmailSent(true);
        conferenceDAO.update(conf);

        return true;
    }




    @Override
    public List<ConferenceDTO> getSentConferences() {
        List<ConferenceDTO> conferenceDTOS = new ArrayList<>();

        List<ConferenceEntity> conferenceEntities = conferenceDAO.getSentConferences();
        if (conferenceEntities!=null){
            for (ConferenceEntity conference:conferenceEntities){
                ConferenceDTO conferenceDTO = new ConferenceDTO();
                BeanUtils.copyProperties(conference,conferenceDTO);
                conferenceDTOS.add(conferenceDTO);
            }
            return conferenceDTOS;

        }
        return Collections.emptyList();
    }

    @Override
    public List<ConferenceDTO> getAllConferences() {
        List<ConferenceDTO> conferenceDTOS = new ArrayList<>();
        List<ConferenceEntity> list = conferenceDAO.getAllConferences();
        for (ConferenceEntity entity : list) {

            ConferenceDTO dto = new ConferenceDTO();

            BeanUtils.copyProperties(entity, dto);

            conferenceDTOS.add(dto);
        }
        return conferenceDTOS;
    }


    //------- password generator
    public String generatePassword(String email) {

        String name = email.split("@")[0];

        if (name.length() >= 4) {
            return name.substring(0, 4) + "@123";
        } else {
            return name + "@123";
        }
    }





    @Override
    public boolean sendReminderToParticipants(int confId) {

        ConferenceEntity conf = conferenceDAO.findById(confId);

        if (conf == null) return false;

        List<ParticipantsEntity> list =
                participantsDAO.getParticipantsByConferenceId(confId);

        if (list == null || list.isEmpty()) return false;

        String subject = "Reminder: " + conf.getConferenceTopic();

        for (ParticipantsEntity p : list) {

            String email = p.getEmail();

            String body = buildReminderEmailBody(conf, email);

            // ✅ IMPORTANT LINE
            emailService.sendHtmlMail(email, subject, body, conf);
        }

        return true;
    }
    private String buildReminderEmailBody(ConferenceEntity conf, String email) {

        String body =
                "<div style='font-family:Segoe UI,Arial,sans-serif;background:#f4f7fb;padding:20px;'>"

                        + "<div style='max-width:650px;margin:auto;background:#ffffff;border-radius:12px;"
                        + "overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,0.1);'>"

                        /* HEADER */
                        + "<div style='background:linear-gradient(90deg,#0f2027,#203a43,#2c5364);"
                        + "color:white;padding:20px;text-align:center;'>"
                        + "<h2 style='margin:0;'>Conference Reminder</h2>"
                        + "<p style='margin:5px 0 0;'>CRDMS Conference System</p>"
                        + "</div>"

                        + "<div style='text-align:center;background:#eef3f8;padding:15px;'>"
                        + "<img src='cid:posterImage' style='max-width:100%;border-radius:10px;'/>"
                        + "</div>"

                        /* BODY */
                        + "<div style='padding:25px;'>"

                        + "<h3 style='color:#2c5364;margin-bottom:10px;'>"
                        + conf.getConferenceTopic()
                        + "</h3>"

                        + "<p style='color:#555;font-size:14px;'>"
                        + "This is a gentle reminder for your upcoming conference. "
                        + "We look forward to your participation."
                        + "</p>"

                        /* DETAILS BOX */
                        + "<div style='background:#f8f9fa;padding:15px;border-radius:10px;margin:15px 0;'>"
                        + "<p><b>Date:</b> " + conf.getDate() + "</p>"
                        + "<p><b>Time:</b> " + conf.getTime() + "</p>"
                        + "</div>"

                        /* HIGHLIGHT MESSAGE */
                        + "<p style='color:#444;font-size:14px;'>"
                        + "Please make sure to join the session on time. "
                        + "Your presence is valuable to us."
                        + "</p>"


                        + "</div>"

                        + "</div>"

                        /* FOOTER */
                        + "<div style='background:#0f2027;color:white;text-align:center;padding:15px;'>"
                        + "<p style='margin:0;'>© 2026 CRDMS Conference System</p>"
                        + "<small>This is an automated reminder email</small>"
                        + "</div>"

                        + "</div>"
                        + "</div>";

        return body;
    }





}
