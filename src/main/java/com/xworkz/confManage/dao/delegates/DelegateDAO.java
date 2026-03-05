package com.xworkz.confManage.dao.delegates;

import com.xworkz.confManage.entity.delegates.DelegateUserEntity;

public interface DelegateDAO {
    DelegateUserEntity findByEmail(String email);

    boolean save(DelegateUserEntity entity);

    DelegateUserEntity loginByEmail(String email);
}
