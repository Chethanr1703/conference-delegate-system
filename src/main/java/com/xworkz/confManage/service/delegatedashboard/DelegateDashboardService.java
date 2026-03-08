package com.xworkz.confManage.service.delegatedashboard;

import com.xworkz.confManage.entity.conference.ConferenceEntity;

import java.util.List;

public interface DelegateDashboardService {

    boolean respondConference(int id,String response);

    List<ConferenceEntity> getConferencesByEmail(String email);

    List<ConferenceEntity> getAllConferencesByEmail(String email);

    List<ConferenceEntity> getAcceptedConferences(String email);
}
