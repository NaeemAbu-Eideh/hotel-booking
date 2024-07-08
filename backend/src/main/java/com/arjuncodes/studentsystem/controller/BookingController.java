package com.arjuncodes.studentsystem.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.arjuncodes.studentsystem.model.Booking;

import com.arjuncodes.studentsystem.model.Request;
import com.arjuncodes.studentsystem.service.BookingService;

@RestController
@RequestMapping("/booking")
public class BookingController 
{
	@Autowired
	private  BookingService bookingservice;
	
	@PostMapping("/add")
	public String addBooking(@RequestBody Booking booking)
	{
		if(bookingservice.addBooking(booking)!=null)
			return "Save Completed";
		else
			return "Cannot Save";
	}
	@GetMapping("/findbooking")
	public String findBooking(String person_name,String person_email,String hotel_name,long roomnum)
	{
		if(bookingservice.findBooking(person_name, person_email, hotel_name,roomnum)!=null)
			return "Founded";
		else
			return null;
	}
	@GetMapping("/getbooking")
	public List<Booking> getBooking(String person_name,String person_email,String hotel_name,long roomnum)
	{
		if(bookingservice.findBooking(person_name, person_email, hotel_name,roomnum)!=null)
			return bookingservice.getBooking(person_name, person_email, hotel_name,roomnum);
		else
			return null;
	}
	@GetMapping("/get")
	public List<Booking> getAllBookings()
	{
		return bookingservice.getAllBookings();
	}
	@DeleteMapping("/delete")
	public String DeleteBooking(String person_name,String person_email,String hotel_name,long roomnum)
	{
		if(bookingservice.deleteBooking(person_name, person_email, hotel_name,roomnum)!=null)
			return "Deleted Complete";
		else
			return null;
	}
	@PutMapping("/accepted")
	public String updateAccepted(String person_name,String person_email,String hotel_name,long roomnum,String accepted,LocalDate start_date,LocalDate end_date)
	{
		if(bookingservice.updateAccepted(person_name, person_email, hotel_name,roomnum,accepted,start_date,end_date)!=null)
			return "Updated Complete";
		else
			return null;
	}
	@PutMapping("/acceptedid")
	public String UpdatedAccepted1(long id,String accepted)
	{
		if(bookingservice.UpdatedAccepted1(id,accepted)!=null)
			return "Updated Complete";
		else
			return null;
	}
	@DeleteMapping("/deleteid")
	public String Deleteid(long id)
	{
		if(bookingservice.Deleteid(id)!=null)
			return "Deleted Complete";
		else
			return null;
	}
	}