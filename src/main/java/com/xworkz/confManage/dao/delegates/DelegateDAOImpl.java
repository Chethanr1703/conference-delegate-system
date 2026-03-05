package com.xworkz.confManage.dao.delegates;


import com.xworkz.confManage.entity.admin.AdminLoginEntity;
import com.xworkz.confManage.entity.delegates.DelegateUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import java.util.List;

@Repository
public class DelegateDAOImpl implements DelegateDAO {

    @Autowired
    private EntityManagerFactory entityManagerFactory;

    @Override
    public DelegateUserEntity findByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        List<DelegateUserEntity> list = entityManager.createQuery(
                        "SELECT d FROM DelegateUserEntity d WHERE d.email = :email",
                        DelegateUserEntity.class)
                .setParameter("email", email)
                .getResultList();

        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public boolean save(DelegateUserEntity entity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(entity);
        entityManager.getTransaction().commit();
        return true;
    }

    @Override
    public DelegateUserEntity loginByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query =entityManager.createQuery("Select ref from DelegateUserEntity ref where ref.email=:email");
        query.setParameter("email",email);

        List<DelegateUserEntity> list = query.getResultList();

        if (!list.isEmpty()) {
            return list.get(0);
        }

        return null;
    }
}