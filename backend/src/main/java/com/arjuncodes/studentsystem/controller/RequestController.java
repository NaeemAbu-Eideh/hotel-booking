package com.arjuncodes.studentsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.Request;
import com.arjuncodes.studentsystem.service.RequestService;

@RestController
@RequestMapping("/request")
public class RequestController
{
@Autowired
private RequestService requestservice;

@PostMapping("/add")
public String addRequest(@RequestBody Request request)
{
	if(requestservice.addRequest(request)!=null)
		return "Save Completed";
	else
		return "Cannot Save";
}
@GetMapping("/findrequest")
public String findRequest(String person_name,String person_email,String hotel_name,long roomnum)
{
	if(requestservice.findRequest(person_name, person_email, hotel_name,roomnum)!=null)
		return "Founded";
	else
		return null;
}
@GetMapping("/getrequest")
public List<Request> getRequesr(String person_name,String person_email,String hotel_name,long roomnum)
{
	if(requestservice.findRequest(person_name, person_email, hotel_name,roomnum)!=null)
		return requestservice.getRequest(person_name, person_email, hotel_name,roomnum);
	else
		return null;
}
@GetMapping("/get")
public List<Request> getAllRequests()
{
	return requestservice.getAllRequests();
}
@DeleteMapping("/delete")
public String DeleteRequest(String person_name,String person_email,String hotel_name,long roomnum)
{
	if(requestservice.deleteRequest(person_name, person_email, hotel_name,roomnum)!=null)
		return "Deleted Complete";
	else
		return null;
}
@DeleteMapping("/deleteid")
public String Deleteid(long id)
{
	if(requestservice.Deleteid(id)!=null)
		return "Deleted Completed";
	else
		return null;
}
}
