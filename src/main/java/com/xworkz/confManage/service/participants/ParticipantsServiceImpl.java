package com.xworkz.confManage.service.participants;

import com.xworkz.confManage.dao.conference.ConferenceDAO;
import com.xworkz.confManage.dao.delegates.DelegateDAO;
import com.xworkz.confManage.dao.participants.ParticipantsDAO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.entity.students.ParticipantsEntity;
import com.xworkz.confManage.utils.ParticipantsValidator;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Collections;
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

                String name = formatter.formatCellValue(row.getCell(1));
                String email = formatter.formatCellValue(row.getCell(2));
                String mobile = formatter.formatCellValue(row.getCell(3));
                String org = formatter.formatCellValue(row.getCell(4));
                String attending = formatter.formatCellValue(row.getCell(5));

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


}

