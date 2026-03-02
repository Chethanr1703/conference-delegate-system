package com.xworkz.confManage.dao.admin;

import com.xworkz.confManage.entity.admin.AdminLoginEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.List;

@Repository
public class AdminDAOImpl implements AdminDAO {
    @Autowired
    EntityManagerFactory entityManagerFactory;


    @Override
    public AdminLoginEntity loginByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query =entityManager.createQuery("Select ref from AdminLoginEntity ref where ref.email=:email");
        query.setParameter("email",email);

        List<AdminLoginEntity> list = query.getResultList();

        if (!list.isEmpty()) {
            return list.get(0);
        }

        return null;
    }
}
