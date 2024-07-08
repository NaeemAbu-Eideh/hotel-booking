package com.arjuncodes.studentsystem.service;

import java.io.IOException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.Notification;
import com.arjuncodes.studentsystem.repository.NotificationRepository;

@Service
public class NotificationService
{
	@Autowired
    private NotificationRepository notificationrepository;

	public String addNotification(Notification notification)
	{
		try
		{
			notificationrepository.save(notification);
			return "Saved Completed";
		}
		catch(Exception e)
		{
			System.out.print(e);
			return null;
		}
	}
	public List<Notification> getAllNotification()
	{
		return notificationrepository.findAll();
	}
	@Transactional
	public String deleteNotificatiin(String send_from_email,String send_to_email,String body,String title,String type)
	{
		if(notificationrepository.findNotification(send_from_email, send_to_email, title, body, type).isEmpty())
			return null;
		else
		{
			notificationrepository.deleteNotification(send_from_email, send_to_email, title, body, type);
			return "Deleted Completed";
		}
	}
	public String deleteId(long id)
	{
		if(notificationrepository.findById(id).isEmpty())
			return null;
		else
		{
			notificationrepository.deleteById(id);
		return "Deleted Completed";
		}
	}
}
