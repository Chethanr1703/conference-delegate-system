package com.xworkz.confManage.service.participants;

import com.xworkz.confManage.dao.conference.ConferenceDAO;
import com.xworkz.confManage.dao.delegates.DelegateDAO;
import com.xworkz.confManage.dao.participants.ParticipantsDAO;
import com.xworkz.confManage.dto.participantsdto.ParticipantsDTO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import com.xworkz.confManage.utils.ParticipantsValidator;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
public class ParticipantsServiceImpl implements ParticipantsService{

    @Autowired
    private ParticipantsDAO participantsDAO;

    @Autowired
    private ConferenceDAO conferenceDAO;

    @Autowired
    private DelegateDAO delegateDAO;

    @Override
    public List<String> processExcel(
            MultipartFile file,
            int conferenceId,
            int delegateId) {

        List<ParticipantsEntity> validParticipants = new ArrayList<>();
        List<String> errors = new ArrayList<>();

        try {
            Workbook workbook =
                    new XSSFWorkbook(file.getInputStream());

            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();

            ConferenceEntity conference =
                    conferenceDAO.findById(conferenceId);

            DelegateUserEntity delegate =
                    delegateDAO.findById(delegateId);

            for(int i=1;i<=sheet.getLastRowNum();i++){

                Row row = sheet.getRow(i);

                if(row == null){
                    continue;
                }

                String name = formatter.formatCellValue(row.getCell(0)).trim();
                String email = formatter.formatCellValue(row.getCell(1));
                String mobile = formatter.formatCellValue(row.getCell(2));
                String org = formatter.formatCellValue(row.getCell(3));
                String attending = formatter.formatCellValue(row.getCell(4));

                // -------- VALIDATIONS --------

                if(!ParticipantsValidator.validName(name)){
                    errors.add("Row "+i+" Invalid Name");
                    continue;
                }

                if(!ParticipantsValidator.validEmail(email)){
                    errors.add("Row "+i+" Invalid Email");
                    continue;
                }

                if(!ParticipantsValidator.validMobile(mobile)){
                    errors.add("Row "+i+" Invalid Mobile Number");
                    continue;
                }

                if(!ParticipantsValidator.validOrganization(org)){
                    errors.add("Row "+i+" Organization Missing");
                    continue;
                }

                if(!ParticipantsValidator.validAttending(attending)){
                    errors.add("Row "+i+" Attending must be YES or NO");
                    continue;
                }

                // -------- ENTITY --------

                ParticipantsEntity p = new ParticipantsEntity();

                p.setFullName(name);
                p.setEmail(email);
                p.setMobile(mobile);
                p.setOrganization(org);
                p.setAttending(attending);

                p.setConference(conference);
                p.setDelegate(delegate);

                validParticipants.add(p);
            }
            participantsDAO.saveAll(validParticipants);


        }
        catch(Exception e){
            errors.add("Excel processing failed.");
            e.printStackTrace();
        }

        return errors;
    }

    @Override
    public List<ParticipantsEntity> getParticipants(int conferenceId, int delegateId) {
        return participantsDAO.findParticipants(conferenceId, delegateId);
    }

    @Override
    public List<ParticipantsEntity> getParticipantsForAdmin(int conferenceId) {
        return participantsDAO.findParticipantsForAdmin(conferenceId);
    }

    @Override
    public boolean registerParticipant(ParticipantsDTO participantsDTO) {
        if(participantsDTO!=null){
            ParticipantsEntity participants = new ParticipantsEntity();
            participants.setFullName(participantsDTO.getFullName());
            participants.setEmail(participantsDTO.getEmail());
            participants.setMobile(participantsDTO.getMobile());
            participants.setOrganization(participantsDTO.getOrganization());
            participants.setAttending(participantsDTO.getAttending());


            // Fetch conference
            ConferenceEntity conference =
                    conferenceDAO.findById(participantsDTO.getConferenceId());

            // Fetch delegate
            DelegateUserEntity delegate =
                    delegateDAO.findById(participantsDTO.getDelegateId());

            participants.setConference(conference);
            participants.setDelegate(delegate);
            System.out.println("Conference ID from DTO: " + participantsDTO.getConferenceId());
            System.out.println("Delegate ID from DTO: " + participantsDTO.getDelegateId());

            return participantsDAO.registerIndividualParticipants(participants);
        }
        return false;
    }

    @Override
    public boolean registerOnlineParticipant(ParticipantsDTO dto) {
        if (dto == null) return false;

        //  Fetch conference
        ConferenceEntity conf =
                conferenceDAO.findById(dto.getConferenceId());

        if (conf == null) return false;

        ParticipantsEntity entity = new ParticipantsEntity();

        // basic fields
        entity.setFullName(dto.getFullName());
        entity.setEmail(dto.getEmail());
        entity.setMobile(dto.getMobile());
        entity.setOrganization(dto.getOrganization());
        entity.setAttending(dto.getAttending());

        //  set conference
        entity.setConference(conf);

        //  HANDLE DELEGATE (IMPORTANT)
        if (dto.getDelegateId() != null) {

            DelegateUserEntity delegate =
                    delegateDAO.findById(dto.getDelegateId());

            if (delegate != null) {
                entity.setDelegate(delegate); // delegate user
            }
        } else {
            entity.setDelegate(null); // public user
        }

        return participantsDAO.save(entity);
    }


}

