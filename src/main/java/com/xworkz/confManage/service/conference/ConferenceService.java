package com.xworkz.confManage.service.conference;

import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;

import java.util.List;

public interface ConferenceService {
    boolean saveConference(ConferenceDTO conferenceDTO);

    List<ConferenceDTO> getUnApprovedConferences();

    List<ConferenceDTO> getApprovedConferences();

    boolean approveConference(int id);

    boolean sendToTPO(int confId);

    List<ConferenceDTO> getSentConferences();
}
