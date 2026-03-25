package com.xworkz.confManage.entity.conference;

import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;


@Data
@Entity
@Table(name = "conferenceDetails")
public class ConferenceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private  String hostName;
    private String email;
    private String delegatesEmail;
    private String conferenceTopic;
    private String targetedAudience;
    private LocalDate date;
    private String time;
    private boolean active = false;
    private boolean emailSent=false;

    private String delegateResponse;
    private boolean emailSentToParticipants;

    @Lob
    @Column(name = "poster")
    private byte[] poster;

    @OneToMany(mappedBy="conference")
    private List<ParticipantsEntity> participants;
}
