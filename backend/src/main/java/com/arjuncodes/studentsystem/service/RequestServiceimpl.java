package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.Request;
import com.arjuncodes.studentsystem.repository.RequestRepository;

@Service
public class RequestServiceimpl implements RequestService
{
@Autowired
private RequestRepository requestrepository;

@Override
public Request addRequest(Request request)
{
	try
	{
		return requestrepository.save(request);
	}
	catch(Exception e)
	{
	System.out.print(e);
	return null;
	}
}
@Override
public String findRequest(String person_name,String person_email,String hotel_name,long roomnum)
{
	if(requestrepository.findRequest(person_name, person_email, hotel_name,roomnum).isEmpty())
		return null;
	else
		return "Founded";
}
@Override
public List<Request> getRequest(String person_name,String person_email,String hotel_name,long roomnum)
{
	if(requestrepository.findRequest(person_name, person_email, hotel_name,roomnum).isEmpty())
		return null;
	else
		return requestrepository.findRequest(person_name, person_email, hotel_name,roomnum);
}
@Transactional
@Override
public String deleteRequest(String person_name, String person_email, String hotel_name,long roomnum)
{
	if(requestrepository.findRequest(person_name, person_email, hotel_name,roomnum).isEmpty())
		return null;
	else
	{
		requestrepository.deleteRequest(person_name, person_email, hotel_name, roomnum);
		return "Deleted Complete";
	}
}
@Override
public List<Request> getAllRequests()
{
	return requestrepository.findAll();
}
@Override
public String Deleteid(long id)
{
	if(requestrepository.findById(id).isEmpty()) 
		return null;
	else
	{
		requestrepository.deleteById(id);
		return "Deleted Completed";
	}
}
}
