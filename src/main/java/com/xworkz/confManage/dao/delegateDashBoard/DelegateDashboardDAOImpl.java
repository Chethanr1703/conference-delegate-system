package com.xworkz.confManage.dao.delegateDashBoard;

import com.xworkz.confManage.entity.conference.ConferenceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.Collections;
import java.util.List;

@Repository
public class DelegateDashboardDAOImpl implements DelegateDashboardDAO{
    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean updateResponse(int id, String response) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        Query query =entityManager.createQuery("UPDATE ConferenceEntity ref SET ref.delegateResponse = :response WHERE ref.id=:id");
        query.setParameter("response",response);
        query.setParameter("id",id);
        int rowEffected =query.executeUpdate();
        entityManager.getTransaction().commit();
        if(rowEffected>0){
            return true;
        }
        return false;
    }

    @Override
    public List<ConferenceEntity> getAcceptedConference(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query=entityManager.createQuery("Select ref From  ConferenceEntity ref  where ref.delegatesEmail LIKE :email and ref.delegateResponse=:status");
        query.setParameter("email","%" + email + "%");
        query.setParameter("status","accepted");
        List<ConferenceEntity> conferenceEntities =query.getResultList();
        return conferenceEntities;
    }

    @Override
    public List<ConferenceEntity> findAllConferencesByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query=entityManager.createQuery("Select ref From  ConferenceEntity ref  where ref.delegatesEmail LIKE :email and ref.emailSent=true");
        query.setParameter("email","%" + email + "%");
        List<ConferenceEntity> conferenceEntities =query.getResultList();
        return conferenceEntities;
    }


    @Override
    public List<ConferenceEntity> findConferencesByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query = entityManager.createQuery("SELECT c FROM ConferenceEntity c WHERE c.delegatesEmail LIKE :email and delegateResponse IS NULL and  c.emailSent=true");

        List<ConferenceEntity> conferenceEntities =query .setParameter("email","%" + email + "%").getResultList();
        return conferenceEntities;
    }

}
