package com.xworkz.confManage.dao.admin;

import com.xworkz.confManage.entity.admin.AdminLoginEntity;

public interface AdminDAO {
    AdminLoginEntity loginByEmail(String email);
}
