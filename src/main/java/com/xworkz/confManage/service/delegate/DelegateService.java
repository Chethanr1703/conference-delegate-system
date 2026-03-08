package com.xworkz.confManage.service.delegate;

import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import com.xworkz.confManage.exception.UserNotFoundException;

public interface DelegateService {

    DelegateUserEntity delegateLogin(String email, String password)throws UserNotFoundException;
}
