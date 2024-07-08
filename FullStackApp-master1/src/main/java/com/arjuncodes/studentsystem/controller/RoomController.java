package com.arjuncodes.studentsystem.controller;

import java.util.List;

import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Room;
import com.arjuncodes.studentsystem.service.CityService;
import com.arjuncodes.studentsystem.service.RoomService;

@RestController
@RequestMapping("/room")
public class RoomController 
{
	@Autowired
	private RoomService roomservice;
	
	
	@PostMapping("/add")
    public String add(@RequestBody Room room)
	{
		if(roomservice.saveRoom(room)!=null)
        return "New login is added";
		else
			return "cannot add";
    }

    @GetMapping("/get")
    public List<Room> list(){
        return roomservice.getAllRoom();
    }
    @DeleteMapping("/delete")
    public String deleteRoom(String hotel_name,int roomnum)
    {
    	if(roomservice.deleteRoom(hotel_name,roomnum)!=null)
    		return "deleted Completed";
    	else
    		return null;
    }
    @PutMapping("/update")
    public String updateRoom(@RequestBody Room room)
    {
    	roomservice.saveRoom(room);
    	return "updated Successfully";
    }
    @GetMapping("/findroom")
    public String FindRoom(int roomnum, String hotel_name)
    {
    	if(roomservice.FindRoom(roomnum,hotel_name)!=null)
    		return "founded";
    	else
    	return null;
    }
    @GetMapping("/getroom")
    public List<Room> getRoom(int roomnum, String hotel_name)
    {
    	if(roomservice.getRoom(roomnum,hotel_name)!=null)
    		return roomservice.getRoom(roomnum,hotel_name);
    	else
    	return null;
    }
    @PutMapping("/reserved")
    public String updateReserved(long roomnum,String hotel_name,String reserved)
    {
    	if(roomservice.updateReserved(roomnum, hotel_name, reserved)!=null)
    	return "updated complete";
    	else
    		return null;
    }
    @PutMapping("/updateinformation")
    public String updateInformation(long roomnum,String hotel_name,String information)
    {
    	if(roomservice.updateInformation(roomnum,hotel_name,information)!=null)
          	return "Updated Completed";
        	else
        	return null;
    }
    }
