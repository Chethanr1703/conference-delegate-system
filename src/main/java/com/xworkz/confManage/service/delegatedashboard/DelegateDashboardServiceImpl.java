package com.xworkz.confManage.service.delegatedashboard;

import com.xworkz.confManage.dao.delegateDashBoard.DelegateDashboardDAO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class DelegateDashboardServiceImpl implements DelegateDashboardService{
    @Autowired
    DelegateDashboardDAO delegateDashboard;


    @Override
    public boolean respondConference(int id,String response) {

        if(id > 0 && response != null){

            return delegateDashboard.updateResponse(id,response);

        }

        return false;
    }

    @Override
    public List<ConferenceEntity> getAcceptedConferences(String email) {
        return delegateDashboard.getAcceptedConference(email);
    }


    @Override
    public List<ConferenceEntity> getConferencesByEmail(String email) {
        return  delegateDashboard.findConferencesByEmail(email);
    }
@Override
   public List<ConferenceEntity> getAllConferencesByEmail(String email){
       return  delegateDashboard.findAllConferencesByEmail(email);
    }
}
