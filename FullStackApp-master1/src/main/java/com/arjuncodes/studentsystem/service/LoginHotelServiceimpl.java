package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.repository.LoginConsRepository;
import com.arjuncodes.studentsystem.repository.LoginHotelRepository;

@Service
public class LoginHotelServiceimpl implements LoginHotelService
{

    @Autowired
    private LoginHotelRepository loginhotelrepository;

    @Override
    public Hotel saveHotel(Hotel hotel) 
    {
        return loginhotelrepository.save(hotel);
    }
@Override
public String deleteHotel(String name)
{
	if(loginhotelrepository.findById(name).isEmpty())
		return null;
	else
	{
	loginhotelrepository.deleteById(name);
	return "delete complete";
	}
}
    @Override
    public List<Hotel> getAllHotel() 
    {
        return loginhotelrepository.findAll();
    }
    @Override
    public String findHotel(String name,String city_name)
    {
    	if(loginhotelrepository.findHotel(name,city_name).isEmpty())
    		return null;
    	else
    		return "founded";
    }
    @Override
    public List<Hotel> getHotel(String name,String city_name)
    {
    	if(loginhotelrepository.findHotel(name,city_name).isEmpty())
    		return null;
    	else
    		return loginhotelrepository.findHotel(name,city_name);
    }
    @Transactional
    @Override
    public String updateInformation(String name,String informartion,String city_name)
    {
	 if(loginhotelrepository.findHotel(name).isEmpty())
		 return null;
	 else
	 {
		 loginhotelrepository.updateInformartion(informartion,name,city_name);
		 return "Updated Completed";
	 }
    }
    @Transactional
    @Override
    public String updateTotrate(double totrate,String name)
    {
    	if(loginhotelrepository.findHotel(name).isEmpty())
    		return null;
    	else
    	{
    		loginhotelrepository.updateTotrate(totrate, name);
    		return "Updated Successfully";
    	}
    }
    @Transactional
    @Override
    public String updateNumrate(double numrate,String name)
    {
    	if(loginhotelrepository.findHotel(name).isEmpty())
    		return null;
    	else
    	{
    		loginhotelrepository.updateNumrate(numrate, name);
    		return "Updated Successfully";
    	}
    }
    @Transactional
    @Override
    public String updateRate(double rate,String name)
    {
    	if(loginhotelrepository.findHotel(name).isEmpty())
    		return null;
    	else
    	{
    		loginhotelrepository.updateRate(rate, name);
    		return "Updated Successfully";
    	}
    }
    }
