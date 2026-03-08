package com.xworkz.confManage.service.delegate;

import com.xworkz.confManage.dao.delegates.DelegateDAO;
import com.xworkz.confManage.entity.admin.AdminLoginEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.exception.UserNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DelegateServiceImpl implements DelegateService {


    @Autowired
    DelegateDAO delegateDAO;


    @Override
    public DelegateUserEntity delegateLogin(String email, String password) {
        if (email == null || !email.contains("@")) {
            throw new UserNotFoundException("Invalid email");
        }
        if (password == null || password.length() < 4) {
            throw new UserNotFoundException("Invalid password");
        }
        DelegateUserEntity delegateUserEntity =delegateDAO.loginByEmail(email);
        if (delegateUserEntity == null) {
            return null; // email not found
        }
        String originalPassward = delegateUserEntity.getPassword();
        if(originalPassward.equals(password)){
            return  delegateUserEntity;
        }else {
            return new DelegateUserEntity();
        }
    }
    }


