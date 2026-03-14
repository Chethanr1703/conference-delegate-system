package com.xworkz.confManage.service.participants;

import com.xworkz.confManage.dto.participantsdto.ParticipantsDTO;
import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

public interface ParticipantsService {

    List<String> processExcel(MultipartFile file,
                              int conferenceId,
                              int delegateId);

    List<ParticipantsEntity> getParticipants(int conferenceId, int delegateId);

    List<ParticipantsEntity> getParticipantsForAdmin(int conferenceId);

    boolean registerParticipant(@Valid ParticipantsDTO participantsDTO);
}
