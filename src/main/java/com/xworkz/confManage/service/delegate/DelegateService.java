package com.xworkz.confManage.service.delegate;

import com.xworkz.confManage.exception.UserNotFoundException;

public interface DelegateService {


    boolean delegateLogin(String email, String password)throws UserNotFoundException;
}
