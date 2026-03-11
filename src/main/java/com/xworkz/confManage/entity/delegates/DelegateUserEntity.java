package com.xworkz.confManage.entity.delegates;

import com.xworkz.confManage.entity.participants.ParticipantsEntity;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "delegates")
@Data

    public class DelegateUserEntity {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private int id;

        private String email;
        private String password;

        private String role; // "TPO" or "HR"

    @OneToMany(mappedBy="delegate")
    private List<ParticipantsEntity> participants;
    }


