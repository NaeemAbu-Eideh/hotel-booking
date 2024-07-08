package com.arjuncodes.studentsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Country;
import com.arjuncodes.studentsystem.service.CountryService;
import com.arjuncodes.studentsystem.service.LoignConsService;

@RestController
@RequestMapping("/country")
public class CountryController 
{
	@Autowired
		private CountryService countryservice;
		
		
		@PostMapping("/add")
	    public String add(@RequestBody Country country){
			countryservice.saveCountry(country);
	        return "New country is added";
	    }

	    @GetMapping("/get")
	    public List<Country> list(){
	        return countryservice.getAllCountries();
	    }
	    @GetMapping("/findcountry")
	    public String FindCountry(String name)
	    {
	    	 if(countryservice.FindCountry(name)!=null)
	    		 return "founded";
	    	 else
		    		return "not founded";
	    }
	    @GetMapping("/getcountry")
	    public List<Country> Find(String name)
	    {
	    	 if(countryservice.FindCountry(name)!=null)
	    		return countryservice.Find(name);
	    	 else
		    		return null;
	    }
	    @DeleteMapping("/delete")
	    public String deleteCountry(@RequestParam String name)
	    {
	    	if(countryservice.deleteCountry(name)!=null)
	    	return "Country Deleted";
	    	else
	    		return "not founded";
	    }
	    @PutMapping("/updatenumrate")
	    public String updateNumrate(double numrate,String name)
	    {
	    	if(countryservice.updateNumrate(numrate, name)!=null)
	          	return "Updated Completed";
	        	else
	        	return null;
	    }
	    @PutMapping("/updatetotrate")
	    public String updateTotrate(double totrate,String name)
	    {
	    	if(countryservice.updateTotrate(totrate, name)!=null)
	          	return "Updated Completed";
	        	else
	        	return null;
	    }
	    @PutMapping("/updaterate")
	    public String updateRate(double rate,String name)
	    {
	    	if(countryservice.updateRate(rate, name)!=null)
	          	return "Updated Completed";
	        	else
	        	return null;
	    }
}
