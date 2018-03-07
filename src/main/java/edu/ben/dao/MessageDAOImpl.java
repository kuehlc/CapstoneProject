package edu.ben.dao;

import edu.ben.model.Conversation;
import edu.ben.model.Message;
import edu.ben.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MessageDAOImpl implements MessageDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveOrUpdate(Conversation conversation) {
        getSession().saveOrUpdate(conversation);
    }

    @Override
    public void createConversation(int user1, int user2) {
        Query q = getSession().createQuery("INSERT INTO conversation (userId_1,userId_2) values (" + user1 + ", " + user2 + ")");
        q.executeUpdate();
    }

    @Override
    public void createConversation(Conversation conversation) {
        getSession().save(conversation);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Conversation> getConversation(int user1) {
        Query q = getSession().createQuery("FROM conversation WHERE userID_1=" + user1 + " OR userID_2=" + user1);
        return (List<Conversation>) q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Message> getMessages(int user1, int user2) {

        Query q = getSession().createQuery("FROM conversation WHERE (userID_1=" + user1 + "AND userID_2=" + user2 + ") OR (userID_1=" + user2 + " AND userID_2=" + user1 + ")");
        Conversation conversation = (Conversation) q.list().get(0);

        q = getSession().createQuery("FROM message WHERE conversation_ID=" + conversation.getId());
        List<Message> msg = (List<Message>) q.list();
        return msg;
    }

    @Override
    public void sendMessage(int user1, int user2, String message) {

        Query q = getSession().createQuery("FROM conversation WHERE (userID_1=" + user1 + "AND userID_2=" + user2 + ") OR (userID_1=" + user2 + " AND userID_2=" + user1 + ")");
        Conversation conversation = (Conversation) q.list().get(0);

        q = getSession().createQuery("INSERT INTO message (conversation_ID, userId, message_body) VALUES (" + conversation.getId() + ", " + user1 + ", " + message + ")");
        q.executeUpdate();
    }

    @Override
    public void sendMessage(Message message) {
        getSession().save(message);
    }

    @Override
    public Conversation getConversationOrderByDateCreated(int user1ID, int user2ID) {
        Query q = getSession().createQuery("FROM conversation WHERE userId_1=:id1 AND userId_2=:id2 ORDER BY date_created DESC");
        q.setParameter("id1", user1ID);
        q.setParameter("id2", user2ID);
        return (Conversation) q.list().get(0);
    }
}
