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

import com.arjuncodes.studentsystem.model.Acceptrequest;
import com.arjuncodes.studentsystem.model.Booking;
import com.arjuncodes.studentsystem.service.AcceptrequestService;

@RestController
@RequestMapping("/acceptrequest")
public class AcceptrequestController 
{
    @Autowired
    private AcceptrequestService acceptrequestservice;
    @PostMapping("/add")
	public String addBooking(@RequestBody Acceptrequest acceptrequest)
	{
		if(acceptrequestservice.addAcceptrequest(acceptrequest)!=null)
			return "Save Completed";
		else
			return "Cannot Save";
	}
	@GetMapping("/findacceptrequest")
	public String findacceptrequest(String person_name,String person_email,String hotel_name,long roomnum)
	{
		if(acceptrequestservice.findAcceptrequest(person_name, person_email, hotel_name,roomnum)!=null)
			return "Founded";
		else
			return null;
	}
	@GetMapping("/getacceptrequest")
	public List<Acceptrequest> getacceptrequest(String person_name,String person_email,String hotel_name,long roomnum)
	{
		if(acceptrequestservice.getAcceptrequest(person_name, person_email, hotel_name,roomnum)!=null)
			return acceptrequestservice.getAcceptrequest(person_name, person_email, hotel_name,roomnum);
		else
			return null;
	}
	@GetMapping("/get")
	public List<Acceptrequest> getAllacceptrequests()
	{
		return acceptrequestservice.getAllAcceptrequests();
	}
	@DeleteMapping("/delete")
	public String Deleteacceptrequest(String person_name,String person_email,String hotel_name,long roomnum)
	{
		if(acceptrequestservice.deleteAcceptrequest(person_name, person_email, hotel_name,roomnum)!=null)
			return "Deleted Complete";
		else
			return null;
	}
	@PutMapping("/accepted")
	public String updateAccepted(String person_name,String person_email,String hotel_name,long roomnum,String accepted)
	{
		if(acceptrequestservice.updateAccepted(person_name, person_email, hotel_name,roomnum,accepted)!=null)
			return "Updated Complete";
		else
			return null;
	}
	@DeleteMapping("/deleteid")
	public String Deleteid(long id)
	{
		if(acceptrequestservice.Deleteid(id)!=null)
			return "Deleted Completed";
		else
			return null;
	}
	}
