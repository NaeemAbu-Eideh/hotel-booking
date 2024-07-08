package com.arjuncodes.studentsystem.service;

import java.time.LocalDate;
import java.util.List;

import com.arjuncodes.studentsystem.model.Booking;
import com.arjuncodes.studentsystem.model.Request;

public interface BookingService
{
	public List<Booking> getAllBookings();
	public Booking addBooking(Booking booking);
	public String findBooking(String person_name,String person_email,String hotel_name,long roomnum);
	public List<Booking> getBooking(String person_name,String person_email,String hotel_name,long roomnum);
	public String deleteBooking(String person_name,String person_email,String hotel_name,long roomnum);
	public String updateAccepted(String person_name,String person_email,String hotel_name,long roomnum,String accepted,LocalDate start,LocalDate end);
	public String Deleteid(long id);
	public String UpdatedAccepted1(long id,String accepted);
}
