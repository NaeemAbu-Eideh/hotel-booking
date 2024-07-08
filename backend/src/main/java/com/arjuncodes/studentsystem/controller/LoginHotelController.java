package com.arjuncodes.studentsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.repository.LoginHotelRepository;
import com.arjuncodes.studentsystem.service.LoginHotelService;
import com.arjuncodes.studentsystem.service.LoignConsService;

@RestController
@RequestMapping("/hotel")
public class LoginHotelController {
	@Autowired
	private LoginHotelService loginhotelservice;
	@Autowired
	LoginHotelRepository hrepo;
	
	@PostMapping("/add")
    public String add(@RequestBody Hotel hotel){
		try
		{
		loginhotelservice.saveHotel(hotel);
        return "New login is added";
		}
		catch(Exception e)
		{
			System.out.print(e);
			return "cannot add";
			
		}
    }
@DeleteMapping("/delete")
public String deleteHotel(String name)
{
	if(loginhotelservice.deleteHotel(name)!=null)
	return "deleted Complete";
	else
		return null;
}
    @GetMapping("/get")
    public List<Hotel> list(){
        return loginhotelservice.getAllHotel();
    }
    @GetMapping("/findhotel")
    public String findHotel(String name,String city_name)
    {
          	if(loginhotelservice.findHotel(name,city_name)!=null)
          		return "founded";
        	else
        	return null;
    }
    @GetMapping("/gethotel")
    public List<Hotel> getHotel(String name,String city_name)
    {
          	if(loginhotelservice.getHotel(name,city_name)!=null)
          	return loginhotelservice.getHotel(name,city_name);
        	else
        	return null;
    }
    @PutMapping("/updateinformation")
    public String updateInformation(String name,String information,String city_name)
    {
    	if(loginhotelservice.updateInformation(name,information,city_name)!=null)
          	return "Updated Completed";
        	else
        	return null;
    }
    @PutMapping("/updatenumrate")
    public String updateNumrate(double numrate,String name)
    {
    	if(loginhotelservice.updateNumrate(numrate, name)!=null)
          	return "Updated Completed";
        	else
        	return null;
    }
    @PutMapping("/updatetotrate")
    public String updateTotrate(double totrate,String name)
    {
    	if(loginhotelservice.updateTotrate(totrate, name)!=null)
          	return "Updated Completed";
        	else
        	return null;
    }
    @PutMapping("/updaterate")
    public String updateRate(double rate,String name)
    {
    	if(loginhotelservice.updateRate(rate, name)!=null)
          	return "Updated Completed";
        	else
        	return null;
    }
}

