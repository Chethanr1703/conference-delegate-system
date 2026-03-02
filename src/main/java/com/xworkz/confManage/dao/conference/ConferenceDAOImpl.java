package com.xworkz.confManage.dao.conference;

import com.xworkz.confManage.entity.conference.ConferenceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.Collections;
import java.util.List;

@Repository
public class ConferenceDAOImpl implements ConferenceDAO{
    @Autowired
    EntityManagerFactory  entityManagerFactory;


    @Override
    public boolean save(ConferenceEntity entity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(entity);
        entityManager.getTransaction().commit();

        return true;
    }

    @Override
    public boolean checkEmailAndConference(String email, String conferenceTopic) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query =entityManager.createQuery("select count(ref) from ConferenceEntity ref where ref.email = :email And ref.conferenceTopic=:conferenceTopic");
        query.setParameter("email",email);
        query.setParameter("conferenceTopic",conferenceTopic);
        Long count=(Long) query.getSingleResult();
        if(count>0){
            return false;
        }
        return true;
    }

    @Override
    public List<ConferenceEntity> getUnApprovedConferences() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query =entityManager.createQuery("from ConferenceEntity ref where ref.active=false");
        List<ConferenceEntity> list =query.getResultList();
        if(list!=null){
            return list;
        }
        return Collections.emptyList();
    }

    @Override
    public List<ConferenceEntity> getApprovedConferences() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
       Query query= entityManager.createQuery("from ConferenceEntity ref where ref.active=true");
        List<ConferenceEntity> list =query.getResultList();
        if(list!=null){
            return list;
        }
        return Collections.emptyList();
    }

    @Override
    public boolean findConferenceToApprove(int id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        Query query= entityManager.createQuery("update ConferenceEntity ref set ref.active = true where ref.id = :id");
        query.setParameter("id",id);
        int rowEffected=query.executeUpdate();
        entityManager.getTransaction().commit();
        if(rowEffected>0){
            return true;
        }
        return false;
    }

    @Override
    public ConferenceEntity findById(int confId) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query= entityManager.createQuery("from ConferenceEntity ref where ref.id =:confId");
        query.setParameter("confId",confId);
        ConferenceEntity conference =(ConferenceEntity) query.getSingleResult();
        if(conference!=null){
            return conference;
        }
        return null;
    }
    @Override
    public boolean update(ConferenceEntity entity) {

        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.merge(entity);
        em.getTransaction().commit();
        return true;
    }

    @Override
    public List<ConferenceEntity> getSentConferences() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query= entityManager.createQuery("from ConferenceEntity ref where ref.emailSent=true");
        List<ConferenceEntity> list =query.getResultList();
        if(list!=null){
            return list;
        }
        return Collections.emptyList();
    }

}
