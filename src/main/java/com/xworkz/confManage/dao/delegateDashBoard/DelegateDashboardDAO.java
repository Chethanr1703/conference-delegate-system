package com.xworkz.confManage.dao.delegateDashBoard;

import com.xworkz.confManage.entity.conference.ConferenceEntity;

import java.util.List;

public interface DelegateDashboardDAO {

        boolean updateResponse(int id,String response);
        
    List<ConferenceEntity> findConferencesByEmail(String email);

    List<ConferenceEntity> getAcceptedConference(String email);

    List<ConferenceEntity> findAllConferencesByEmail(String email);
}
