package com.xworkz.confManage.entity.admin;

import lombok.Data;

import javax.persistence.*;
@Data
@Table(name = "AdminLogin")
@Entity
public class AdminLoginEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String email;
    String password;
}
