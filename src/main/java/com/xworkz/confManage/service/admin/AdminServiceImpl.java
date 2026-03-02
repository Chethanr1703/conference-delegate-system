package com.xworkz.confManage.service.admin;

import com.xworkz.confManage.dao.admin.AdminDAO;
import com.xworkz.confManage.entity.admin.AdminLoginEntity;
import com.xworkz.confManage.exception.UserNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminDAO adminDAO;

    @Override
    public boolean adminLogin(String email, String password) throws UserNotFoundException {
        if (email == null || !email.contains("@")) {
            throw new UserNotFoundException("Invalid email");
        }
        if (password == null || password.length() < 8) {
           throw new UserNotFoundException("Invalid password");
        }
         AdminLoginEntity adminLoginEntity =adminDAO.loginByEmail(email);
        if (adminLoginEntity == null) {
            return false; // email not found
        }
        String originalPassward = adminLoginEntity.getPassword();
        if(originalPassward.equals(password)){
            return  true;
        }else {
            return false;
        }
    }
}
