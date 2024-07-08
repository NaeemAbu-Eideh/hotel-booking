package com.arjuncodes.studentsystem.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Hotel;

public interface LoginHotelService
{
    public Hotel saveHotel(Hotel hotel);
    public String deleteHotel(String name);
    public List<Hotel> getAllHotel();
    public String findHotel(String name,String city_name);
    public List<Hotel> getHotel(String name,String city_name);
    public String updateInformation(String name,String informartion,String city_name);
    public String updateTotrate(double totrate,String name);
    public String updateNumrate(double numrate,String name);
    public String updateRate(double rate,String name);


}
