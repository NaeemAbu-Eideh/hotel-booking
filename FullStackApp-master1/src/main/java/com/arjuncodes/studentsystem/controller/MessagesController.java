package com.arjuncodes.studentsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.Messages;
import com.arjuncodes.studentsystem.model.Notification;
import com.arjuncodes.studentsystem.service.MessagesService;
import com.arjuncodes.studentsystem.service.NotificationService;

@RestController
@RequestMapping("messages")
public class MessagesController
{
	@Autowired
	private MessagesService messageservice;

	@PostMapping("/add")
	public String addNotification(@RequestBody Messages messages)
	{
		if(messageservice.addMessages(messages)!=null)
			return "Saved Completed";
		else
			return "Cannot Save";
	}
	@DeleteMapping("/delete")
	public String deleteNotification(String send_from_email,String send_to_email,String body,String title)
	{
	if(messageservice.deleteMessages(send_from_email, send_to_email, body, title)!=null)
		return "Deleted Completed";
	else
		return null;
	}
	@GetMapping("/get")
	public List<Messages> getAllNotifiactions(String send_from_email,String send_to_email)
	{
			return messageservice.getAllMessages();
	}
	@DeleteMapping("deleteid")
	public String DeleteId(long id)
	{
		if( messageservice.deleteId(id)!=null)
			return "Deleted Completed";
		else
			return null;
	}
	@PutMapping("/updatetype")
	public String updateType(String type,String send_from_email,String send_to_email,String body,String title)
	{
		if(messageservice.updatetype(type, send_from_email, send_to_email, body, title)!=null)
			return "Updated Completed";
		else
			return null;
	}
}
