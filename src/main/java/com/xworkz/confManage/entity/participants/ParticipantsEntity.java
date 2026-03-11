package com.xworkz.confManage.entity.participants;

import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name="Participants")
public class ParticipantsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fullName;

    private String email;

    private String mobile;

    private String organization;

    private String attending;

    @ManyToOne
    @JoinColumn(name="conference_id")
    private ConferenceEntity conference;

    @ManyToOne
    @JoinColumn(name="delegate_id")
    private DelegateUserEntity delegate;
}