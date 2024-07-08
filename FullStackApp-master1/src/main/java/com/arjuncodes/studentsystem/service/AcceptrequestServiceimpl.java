package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.Acceptrequest;
import com.arjuncodes.studentsystem.model.Booking;
import com.arjuncodes.studentsystem.repository.AcceptrequestRepository;

@Service
public class AcceptrequestServiceimpl implements AcceptrequestService
{
   @Autowired
   private AcceptrequestRepository acceptrequestrepository;
   @Override
   public Acceptrequest addAcceptrequest(Acceptrequest acceptrequest)
   {
   	try
   	{
   		return acceptrequestrepository.save(acceptrequest);
   	}
   	catch(Exception e)
   	{
   	System.out.print(e);
   	return null;
   	}
   }
   @Override
   public String findAcceptrequest(String person_name,String person_email,String hotel_name,long roomnum)
   {
   	if(acceptrequestrepository.findAcceptrequest(person_name, person_email, hotel_name,roomnum).isEmpty())
   		return null;
   	else
   		return "Founded";
   }
   @Override
   public List<Acceptrequest> getAcceptrequest(String person_name,String person_email,String hotel_name,long roomnum)
   {
   	if(acceptrequestrepository.findAcceptrequest(person_name, person_email, hotel_name,roomnum).isEmpty())
   		return null;
   	else
   		return acceptrequestrepository.findAcceptrequest(person_name, person_email, hotel_name,roomnum);
   }
   @Transactional
   @Override
   public String deleteAcceptrequest(String person_name,String person_email,String hotel_name,long roomnum)
   {
   	if(acceptrequestrepository.findAcceptrequest(person_name, person_email, hotel_name,roomnum).isEmpty())
   		return null;
   	else
   	{
   		acceptrequestrepository.deleteAcceptrequest(person_name, person_email, hotel_name,roomnum);
   		return "Deleted Complete";
   	}
   }
   @Transactional
   @Override
   public String updateAccepted(String person_name,String person_email,String hotel_name,long roomnum,String Accepted)
   {
	   if(acceptrequestrepository.findAcceptrequest(person_name, person_email, hotel_name,roomnum).isEmpty())
	   		return null;
	   	else
	   	{
	   		acceptrequestrepository.updateAccepted(person_name, person_email, hotel_name, roomnum, Accepted);
	   		return "Updated Complete";
	   	}
	   }
   @Override
   public List<Acceptrequest> getAllAcceptrequests()
   {
   	return acceptrequestrepository.findAll();
   }
   @Override
   public String Deleteid(long id)
   {
   	if(acceptrequestrepository.findById(id).isEmpty()) 
   		return null;
   	else
   	{
   		acceptrequestrepository.deleteById(id);
   		return "Deleted Completed";
   	}
   }
   }