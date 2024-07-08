package com.arjuncodes.studentsystem.service;

import java.util.List;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Country;

public interface CountryService
{
	public Country saveCountry(Country country);
    public List<Country> getAllCountries();
    public String deleteCountry(String name);
    public String FindCountry(String name);
    public List <Country> Find(String name);
    public String updateTotrate(double totrate,String name);
    public String updateNumrate(double numrate,String name);
    public String updateRate(double rate,String name);

}
