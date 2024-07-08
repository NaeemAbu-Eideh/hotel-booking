package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Country;
import com.arjuncodes.studentsystem.repository.CountryRepository;
import com.arjuncodes.studentsystem.repository.LoginConsRepository;

@Service
public class CountryServiceimpl implements CountryService
{
	@Autowired
    private CountryRepository countryreposistory;

    @Override
    public Country saveCountry(Country country) {
        return countryreposistory.save(country);
    }

    @Override
    public List<Country> getAllCountries() 
    {
        return countryreposistory.findAll();
    }
   
    @Override
     public String deleteCountry(String name)
    {
    	if(countryreposistory.findById(name).isEmpty())
    		return null;
    	else
    	{
    	countryreposistory.deleteById(name);
    	return "deleted Complete";
    	}
    }
    @Override
    public String FindCountry(String name)
    {
    	if(countryreposistory.FindCountry(name).isEmpty())
    		return null;
    	else
    		return "founded";
    }
    @Override
    public List<Country> Find(String name)
    {
    	if(countryreposistory.FindCountry(name).isEmpty())
    		return null;
    	else
    		return countryreposistory.FindCountry(name);
    }
    @Transactional
    @Override
    public String updateTotrate(double totrate,String name)
    {
    	if(countryreposistory.FindCountry(name).isEmpty())
    		return null;
    	else
    	{
    		countryreposistory.updateTotrate(totrate, name);
    		return "Updated Successfully";
    	}
    }
    @Transactional
    @Override
    public String updateNumrate(double numrate,String name)
    {
    	if(countryreposistory.FindCountry(name).isEmpty())
    		return null;
    	else
    	{
    		countryreposistory.updateNumrate(numrate, name);
    		return "Updated Successfully";
    	}
    }
    @Transactional
    @Override
    public String updateRate(double rate,String name)
    {
    	if(countryreposistory.FindCountry(name).isEmpty())
    		return null;
    	else
    	{
    		countryreposistory.updateRate(rate, name);
    		return "Updated Successfully";
    	}
    }
}
