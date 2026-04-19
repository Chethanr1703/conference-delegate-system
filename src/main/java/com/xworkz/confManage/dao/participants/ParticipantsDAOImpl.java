package com.xworkz.confManage.dao.participants;

import com.xworkz.confManage.entity.participants.ParticipantsEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

@Repository
public class ParticipantsDAOImpl implements ParticipantsDAO{

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public void saveAll(List<ParticipantsEntity> validParticipants) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            entityManager.getTransaction().begin();
            for (ParticipantsEntity p : validParticipants) {
                entityManager.persist(p);
            }
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            entityManager.getTransaction().rollback();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<ParticipantsEntity> findParticipants(int conferenceId, int delegateId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        List<ParticipantsEntity> list =
                entityManager.createQuery(
                                "FROM ParticipantsEntity p WHERE p.conference.id=:confId AND p.delegate.id=:delId",
                                ParticipantsEntity.class)
                        .setParameter("confId", conferenceId)
                        .setParameter("delId", delegateId)
                        .getResultList();

        return list;
    }

    @Override
    public List<ParticipantsEntity> findParticipantsForAdmin(int conferenceId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        List<ParticipantsEntity> list =
                entityManager.createQuery(
                                "FROM ParticipantsEntity p WHERE p.conference.id=:confId",
                                ParticipantsEntity.class)
                        .setParameter("confId", conferenceId)
                        .getResultList();

        return list;
    }

    @Override
    public boolean registerIndividualParticipants(ParticipantsEntity participants) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(participants);
        entityManager.getTransaction().commit();
        return true;
    }
    @Override
    public List<ParticipantsEntity> getParticipantsByConferenceId(int conferenceId) {

        EntityManager em = entityManagerFactory.createEntityManager();

        return em.createQuery(
                        "SELECT p FROM ParticipantsEntity p WHERE p.conference.id = :cid",
                        ParticipantsEntity.class)
                .setParameter("cid", conferenceId)
                .getResultList();
    }

    @Override
    public boolean save(ParticipantsEntity entity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(entity);
        entityManager.getTransaction().commit();
        return true;
    }
}
