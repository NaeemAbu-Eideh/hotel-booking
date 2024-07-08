package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.repository.CityRepository;

@Service
public class CityServiceimpl implements CityService
{
    @Autowired
    private CityRepository cityrepository;
    
    @Override
    public City saveCity(City city)
    {
    	try {
    	return cityrepository.save(city);
    	}
    	catch(Exception e)
    	{
    	System.out.print(e);
    	return null;
    	}
    }
    @Override
    public List<City> getAllCities()
    {
    	return cityrepository.findAll();
    }
    @Override
    public String deleteCity(String name)
    {
    	if(cityrepository.findById(name).isEmpty())
    	{
    		return null;
    	}
    	else
    	cityrepository.deleteById(name); 
        return "deleted";
    }
    @Override
    public String FindCity (String name)
    {
    	if(cityrepository.Find(name).isEmpty())
    		return null;
    	else
    		return "Founded";
    }
    @Override
    public List<City> Find(String name)
    {
    	if(cityrepository.Find(name).isEmpty())
    		return null;
    	else
    		return cityrepository.Find(name);
    }
    @Override
    public City updateCity(City city)
    {
    	return cityrepository.save(city);
    }
    @Override
    public String findCity(String name,String country_name)
    {
    	if(cityrepository.findCity(name, country_name).isEmpty())
    		return null;
    	else
    		return "founded";
    }
    @Override
    public List<City> getCity(String name,String country_name)
    {
    	if(cityrepository.findCity(name, country_name).isEmpty())
    		return null;
    	else
    		return cityrepository.findCity(name, country_name);
    }
    @Transactional
    @Override
    public String updateTotrate(double totrate,String name,String country_name)
    {
    	if(cityrepository.findCity(name, country_name).isEmpty())
    		return null;
    	else
    	{
    		cityrepository.updateTotrate(totrate, name,country_name);
    		return "Updated Successfully";
    	}
    }
    @Transactional
    @Override
    public String updateNumrate(double numrate,String name,String country_name)
    {
    	if(cityrepository.findCity(name, country_name).isEmpty())
    		return null;
    	else
    	{
    		cityrepository.updateNumrate(numrate, name,country_name);
    		return "Updated Successfully";
    	}
    }
    @Transactional
    @Override
    public String updateRate(double rate,String name,String country_name)
    {
    	if(cityrepository.findCity(name, country_name).isEmpty())
    		return null;
    	else
    	{
    		cityrepository.updateRate(rate, name,country_name);
    		return "Updated Successfully";
    	}
    }
}