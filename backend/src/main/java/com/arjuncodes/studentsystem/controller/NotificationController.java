package com.arjuncodes.studentsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.Notification;
import com.arjuncodes.studentsystem.service.NotificationService;

@RestController
@RequestMapping("/notification")
public class NotificationController 
{
@Autowired
private NotificationService notificationservice;

@PostMapping("/add")
public String addNotification(@RequestBody Notification notication)
{
	if(notificationservice.addNotification(notication)!=null)
		return "Saved Completed";
	else
		return "Cannot Save";
}
@DeleteMapping("/delete")
public String deleteNotification(String send_from_email,String send_to_email,String body,String title,String type)
{
if(notificationservice.deleteNotificatiin(send_from_email, send_to_email, body, title, type)!=null)
	return "Deleted Completed";
else
	return null;
}
@GetMapping("/get")
public List<Notification> getAllNotifiactions(String send_from_email,String send_to_email)
{
		return notificationservice.getAllNotification();
}
@DeleteMapping("deleteid")
public String DeleteId(long id)
{
	if( notificationservice.deleteId(id)!=null)
		return "Deleted Completed";
	else
		return null;
}
}