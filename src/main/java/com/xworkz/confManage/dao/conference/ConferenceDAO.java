package com.xworkz.confManage.dao.conference;

import com.xworkz.confManage.dto.conferencedto.ConferenceDTO;
import com.xworkz.confManage.entity.conference.ConferenceEntity;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.List;

public interface ConferenceDAO {
    boolean save(ConferenceEntity entity);

    boolean checkEmailAndConference(@NotNull(message =" Email is required") @Pattern(regexp = "^[a-zA-Z0-9._%+-]+@gmail\\.com$",message = "email is not valid") String email, @NotNull(message = "Conference topic is required") @Size(min = 5, max = 100, message = "Conference topic must be between 5 and 100 characters") String conferenceTopic);

    List<ConferenceEntity> getUnApprovedConferences();

    List<ConferenceEntity> getApprovedConferences();

    boolean findConferenceToApprove(int id);

    ConferenceEntity findById(int confId);

    boolean update(ConferenceEntity conf);

    List<ConferenceEntity> getSentConferences();

    List<ConferenceEntity> getAllConferences();
}
