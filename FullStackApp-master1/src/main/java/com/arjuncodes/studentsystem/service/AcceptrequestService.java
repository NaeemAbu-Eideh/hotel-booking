package com.arjuncodes.studentsystem.service;

import java.util.List;

import com.arjuncodes.studentsystem.model.Acceptrequest;
import com.arjuncodes.studentsystem.model.Booking;

public interface AcceptrequestService
{
	public List<Acceptrequest> getAllAcceptrequests();
	public Acceptrequest addAcceptrequest(Acceptrequest acceptrequest);
	public String findAcceptrequest(String person_name,String person_email,String hotel_name,long roomnum);
	public List<Acceptrequest> getAcceptrequest(String person_name,String person_email,String hotel_name,long roomnum);
	public String deleteAcceptrequest(String person_name,String person_email,String hotel_name,long roomnum);
	public String updateAccepted(String person_name,String person_email,String hotel_name,long roomnum,String accepted);
	public String Deleteid(long id);
}
