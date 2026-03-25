package com.xworkz.confManage.service.conference;

import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

public interface ConferenceService {


    List<ConferenceDTO> getUnApprovedConferences();

    List<ConferenceDTO> getApprovedConferences();

    boolean approveConference(int id);

    boolean sendToTPO(int confId);

    List<ConferenceDTO> getSentConferences();


    List<ConferenceDTO> getAllConferences();

    boolean saveConference(@Valid ConferenceDTO conferenceDTO, MultipartFile poster, MultipartFile delegateFile);
}
