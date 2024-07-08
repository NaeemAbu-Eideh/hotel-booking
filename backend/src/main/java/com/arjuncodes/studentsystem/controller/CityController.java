package com.arjuncodes.studentsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.service.CityService;
import com.arjuncodes.studentsystem.service.LoignConsService;

@RestController
@RequestMapping("/city")
public class CityController 
{
		@Autowired
		private CityService cityservice;
		
		
		@PostMapping("/add")
	    public String add(@RequestBody City city)
		{
			if(cityservice.saveCity(city)!=null)
	        return "New login is added";
			else
				return "cannot add";
	    }

	    @GetMapping("/get")
	    public List<City> list(){
	        return cityservice.getAllCities();
	    }
	    @DeleteMapping("/delete")
	    public String deleteCity(String name)
	    {
	    	if(cityservice.deleteCity(name)!=null)
	    		return "deleted";
	    	else
	    		return "not founded";
	    }
	    @PutMapping("/update")
	    public String updateCity(@RequestBody City city)
	    {
	    	try
	    	{
	    		cityservice.saveCity(city);
	    	return "update succesfully";
	    	}
	    	catch (Exception e)
	    	{
	    		System.out.print(e);
	    		return "cannot update";
	    	}
}
	    @GetMapping("/findcity")
	    public String findCity(String name,String country_name)
	    {
	    	if(cityservice.findCity(name, country_name)!=null)
	    		return "founded";
	    		else
	    			return null;
	    }
	    @GetMapping("/getcity")
	    public List<City> getCity(String name,String country_name)
	    {
	    	if(cityservice.getCity(name, country_name)!=null)
	    		return cityservice.getCity(name, country_name);
	    		else
	    			return null;
	    }
	    @PutMapping("/updatenumrate")
	    public String updateNumrate(double numrate,String name,String country_name)
	    {
	    	if(cityservice.updateNumrate(numrate, name,country_name)!=null)
	          	return "Updated Completed";
	        	else
	        	return null;
	    }
	    @PutMapping("/updatetotrate")
	    public String updateTotrate(double totrate,String name,String country_name)
	    {
	    	if(cityservice.updateTotrate(totrate, name,country_name)!=null)
	          	return "Updated Completed";
	        	else
	        	return null;
	    }
	    @PutMapping("/updaterate")
	    public String updateRate(double rate,String name,String country_name)
	    {
	    	if(cityservice.updateRate(rate, name,country_name)!=null)
	          	return "Updated Completed";
	        	else
	        	return null;
	    }
}
