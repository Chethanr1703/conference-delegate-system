package com.xworkz.confManage.service.conference;

import com.xworkz.confManage.dao.conference.ConferenceDAO;
import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
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

    @Override
    public boolean sendToTPO(int confId) {
        ConferenceEntity conf = conferenceDAO.findById(confId);

        if (conf == null) return false;

        // ✅ Get multiple emails
        String emails = conf.getDelegatesEmail();

        if (emails == null || emails.isEmpty()) return false;

        // ✅ Split emails
        String[] emailList = emails.split(",");

        String link = "http://192.168.117.125:8080/studentRegister?confId=" + confId;

        String subject = "Conference Notification";

        String body = "Conference: " + conf.getConferenceTopic()
                + "\nDate: " + conf.getDate()
                + "\nTime: " + conf.getTime()
                + "\n\nPlease forward to students."
                + "\n\nRegistration Link:\n" + link;

        // ✅ Send to ALL TPOs
        for (String email : emailList) {
            emailService.sendHtmlMail(email.trim(), subject, body);
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


}
