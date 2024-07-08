package com.arjuncodes.studentsystem.service;

import java.util.List;
import java.time.LocalDate;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.Booking;
import com.arjuncodes.studentsystem.model.Request;
import com.arjuncodes.studentsystem.repository.BookingRepository;

import net.bytebuddy.asm.Advice.Local;

@Service
public class BookingServiceimpl implements BookingService 
{
  @Autowired
  private BookingRepository bookingrepository;
  
  @Override
  public Booking addBooking(Booking booking)
  {
  	try
  	{
  		return bookingrepository.save(booking);
  	}
  	catch(Exception e)
  	{
  	System.out.print(e);
  	return null;
  	}
  }
  @Override
  public String findBooking(String person_name,String person_email,String hotel_name,long roomnum)
  {
  	if(bookingrepository.findBooking(person_name, person_email, hotel_name,roomnum).isEmpty())
  		return null;
  	else
  		return "Founded";
  }
  @Override
  public List<Booking> getBooking(String person_name,String person_email,String hotel_name,long roomnum)
  {
  	if(bookingrepository.findBooking(person_name, person_email, hotel_name,roomnum).isEmpty())
  		return null;
  	else
  		return bookingrepository.findBooking(person_name, person_email, hotel_name,roomnum);
  }
  @Transactional
  @Override
  public String deleteBooking(String person_name,String person_email,String hotel_name,long roomnum)
  {
  	if(bookingrepository.findBooking(person_name, person_email, hotel_name,roomnum).isEmpty())
  		return null;
  	else
  	{
  		bookingrepository.deleteBooking(person_name, person_email, hotel_name,roomnum);
  		return "Deleted Complete";
  	}
  }
  @Override
  public List<Booking> getAllBookings()
  {
  	return bookingrepository.findAll();
  }
  @Transactional
  @Override
  public String updateAccepted(String person_name,String person_email,String hotel_name,long roomnum,String accepted,LocalDate start_date,LocalDate end_date)
  {
	  if(bookingrepository.findBooking2(person_name, person_email, hotel_name,roomnum,start_date,end_date).isEmpty())
	  		return null;
	  	else
	  	{
	  		bookingrepository.updateAccepted(person_name, person_email, hotel_name, roomnum, accepted,start_date,end_date);
	  		return "Updated Complete";
	  	}
  }
  @Override
  public String Deleteid(long id)
  {
	  if(bookingrepository.findById(id).isEmpty())
		  return null;
	  else
	  {
		  bookingrepository.deleteById(id);
		  return "Deleted Completed";
		  }
  }
  @Transactional
  @Override
  public String UpdatedAccepted1(long id,String accepted)
  {
	 if(bookingrepository.findById(id).isEmpty())
		 return null;
	 else
	 {
		 bookingrepository.updateAccepted1(accepted, id); 
		 return "Updated Completed";
	 }
  }
  }
