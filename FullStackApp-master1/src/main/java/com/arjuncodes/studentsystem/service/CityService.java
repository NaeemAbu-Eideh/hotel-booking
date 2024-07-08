package com.arjuncodes.studentsystem.service;

import java.util.List;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;

public interface CityService
{
public City saveCity(City city);
public List<City> getAllCities();
public String deleteCity (String name);
public String FindCity (String name);
public List<City> Find (String name);
public City updateCity (City city); 
public String findCity(String name,String country_name);
public List<City> getCity(String name,String country_name);
public String updateTotrate(double totrate,String name,String country_name);
public String updateNumrate(double numrate,String name,String country_name);
public String updateRate(double rate,String name,String country_name);
}
