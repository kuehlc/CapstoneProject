package edu.ben.service;

import edu.ben.model.Message;
import edu.ben.model.User;

import java.util.List;

public interface MessageService {
    public void createConversation(User user1, User user2);

    public List<Message> getConversation(User user1, User user2);

    public void sendMessage(User user, User sendTo, String message);


}