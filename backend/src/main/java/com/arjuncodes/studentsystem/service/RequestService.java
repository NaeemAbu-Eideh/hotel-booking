package com.arjuncodes.studentsystem.service;

import java.util.List;

import com.arjuncodes.studentsystem.model.Request;

public interface RequestService 
{
public List<Request> getAllRequests();
public Request addRequest(Request request);
public String findRequest(String person_name,String person_email,String hotel_name,long roomnum);
public List<Request> getRequest(String person_name,String person_email,String hotel_name,long roomnum);
public String deleteRequest(String person_name,String person_email,String hotel_name,long roomnum);
public String Deleteid(long id);
}