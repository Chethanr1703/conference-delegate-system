package com.xworkz.confManage.service.conference;

import com.xworkz.confManage.dao.conference.ConferenceDAO;
import com.xworkz.confManage.dao.delegateDashBoard.DelegateDashboardDAO;
import com.xworkz.confManage.dao.delegates.DelegateDAO;
import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.utils.EmailService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public boolean saveConference(ConferenceDTO conferenceDTO) {
        boolean isValid = true;

        // ===== VALIDATIONS =====

        if (conferenceDTO == null) {
            isValid = false;
        }

        if (conferenceDTO.getHostName() == null ||
                conferenceDTO.getHostName().trim().isEmpty()) {
            isValid = false;
        }

        if (conferenceDTO.getEmail() == null ||
                !conferenceDTO.getEmail().contains("@")) {
            isValid = false;
        }

        if (conferenceDTO.getConferenceTopic() == null ||
                conferenceDTO.getConferenceTopic().trim().length() < 5) {
            isValid = false;
        }

        if (conferenceDTO.getTargetedAudience() == null ||
                conferenceDTO.getTargetedAudience().trim().isEmpty()) {
            isValid = false;
        }

        // Date must not be past
        if (conferenceDTO.getDate() == null ||
                conferenceDTO.getDate().isBefore(LocalDate.now())) {
            isValid = false;
        }

        if (conferenceDTO.getTime() == null) {
            isValid = false;
        }
        if (isValid) {
            boolean isAvailable = conferenceDAO.checkEmailAndConference(conferenceDTO.getEmail(), conferenceDTO.getConferenceTopic());
            if (isAvailable==false) {
                return false;
            } else {
                ConferenceEntity entity = new ConferenceEntity();
                BeanUtils.copyProperties(conferenceDTO, entity);
                entity.setActive(false);

                boolean isSaved = conferenceDAO.save(entity);
                if (isSaved) {
                    return isSaved;
                } else {
                    isSaved=false;
                    return isSaved;
                }
            }
        }
        return false;
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

        String link = "http://192.168.117.125:8080/conference/delegatesRegister?confId=" + confId;

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


            String body = "Conference: " + conf.getConferenceTopic()
                    + "<br>Date: " + conf.getDate()
                    + "<br>Time: " + conf.getTime()
                    + "<br><br><b>Your Login Credentials</b>"
                    + "<br>Email: " + email
                    + "<br>Password: " + password
                    + "<br><br>Login here: http://192.168.117.125:8080/conference/delegateLogin"
                    + "<br><br><b>Student Registration Link:</b>"
                    + "<br>" + link;

            emailService.sendHtmlMail(email, subject, body);
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


    public String generatePassword(String email) {

        String name = email.split("@")[0];

        if (name.length() >= 4) {
            return name.substring(0, 4) + "@123";
        } else {
            return name + "@123";
        }
    }









}
