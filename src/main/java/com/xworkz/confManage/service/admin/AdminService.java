package com.xworkz.confManage.service.admin;

import com.xworkz.confManage.exception.UserNotFoundException;

public interface AdminService {
    boolean adminLogin(String email, String password)  throws UserNotFoundException;
}
