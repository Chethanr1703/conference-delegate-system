package com.xworkz.confManage.entity.delegates;

import lombok.Data;

import javax.persistence.*;

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
    }


