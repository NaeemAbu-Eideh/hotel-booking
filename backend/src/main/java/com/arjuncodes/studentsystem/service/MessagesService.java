package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.Messages;
import com.arjuncodes.studentsystem.model.Notification;
import com.arjuncodes.studentsystem.repository.MessagesRepository;
import com.arjuncodes.studentsystem.repository.NotificationRepository;

@Service
public class MessagesService 
{
	@Autowired
    private MessagesRepository messagesrepository;

	public String addMessages(Messages messages)
	{
		try
		{
			messagesrepository.save(messages);
			return "Saved Completed";
		}
		catch(Exception e)
		{
			System.out.print(e);
			return null;
		}
	}
	public List<Messages> getAllMessages()
	{
		return messagesrepository.findAll();
	}
	@Transactional
	public String deleteMessages(String send_from_email,String send_to_email,String body,String title)
	{
		if(messagesrepository.findMessages(send_from_email, send_to_email, title, body).isEmpty())
			return null;
		else
		{
			messagesrepository.deleteMessages(send_from_email, send_to_email, title, body);
			return "Deleted Completed";
		}
	}
	public String deleteId(long id)
	{
		if(messagesrepository.findById(id).isEmpty())
			return null;
		else
		{
		messagesrepository.deleteById(id);
		return "Deleted Completed";
		}
	}
	@Transactional
	public String updatetype(String type,String send_from_email,String send_to_email,String body,String title)
	{
		if(messagesrepository.findMessages(send_from_email, send_to_email, title, body).isEmpty())
			return null;
		else
		{
			messagesrepository.updatetype(type, send_from_email, send_to_email, title, body);
			return "Updated Completed";
		}
	}
}
