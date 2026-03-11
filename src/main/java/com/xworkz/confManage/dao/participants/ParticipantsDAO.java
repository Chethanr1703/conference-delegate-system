package com.xworkz.confManage.dao.participants;

import com.xworkz.confManage.entity.participants.ParticipantsEntity;

import java.util.List;

public interface ParticipantsDAO {
    void  saveAll(List<ParticipantsEntity> validParticipants);

    List<ParticipantsEntity> findParticipants(int conferenceId, int delegateId);

    List<ParticipantsEntity> findParticipantsForAdmin(int conferenceId);
}
