package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.persistence.Table;
import org.springframework.data.jpa.repository.Modifying;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Room;
import com.arjuncodes.studentsystem.repository.CityRepository;
import com.arjuncodes.studentsystem.repository.RoomRepository;

@Service
public class RoomServiceimpl implements RoomService
{
	@Autowired
    private RoomRepository roomrepository;
    
    @Override
    public Room saveRoom(Room room)
    {
    	try {
    	return roomrepository.save(room);
    	}
    	catch(Exception e)
    	{
    	System.out.print(e);
    	return null;
    	}
    }
    @Override
    public List<Room> getAllRoom()
    {
    	return roomrepository.findAll();
    }
    @Transactional
    @Override
    public String deleteRoom(String hotel_name,int roomnum)
    {
    	if(roomrepository.findRoom(roomnum, hotel_name).isEmpty())
    	{
    		return null;
    	}
    	else
    	roomrepository.deleteRoom(hotel_name, roomnum); 
        return "deleted Complete";
    }
    @Override
    public String FindRoom(int roomnum,String hotel_name)
    {
    	if(roomrepository.findRoom(roomnum,hotel_name).isEmpty())
    	{
    		return null;
    	}
    	else
    	roomrepository.findRoom(roomnum,hotel_name); 
        return "founded";
    }
    @Override
	public List<Room> getRoom(int roomnum,String hotel_name)
	{
    	if(roomrepository.findRoom(roomnum,hotel_name).isEmpty())
    		return null;
    	else
    	return roomrepository.findRoom(roomnum,hotel_name); 
	}
    @Override
    @Transactional
	public String updateReserved(long roomnum,String hotel_name,String reserved)
	{
    	if(roomrepository.findRoom(roomnum, hotel_name).isEmpty())
    			return null;
    	else
    	{
    		roomrepository.updateRoom(reserved,hotel_name,roomnum);
    		return "updated Complete";
    	}		   	
	}
    @Override
    @Transactional
	public String updateInformation(long roomnum,String hotel_name,String infor)
	{
    	if(roomrepository.findRoom(roomnum, hotel_name).isEmpty())
    			return null;
    	else
    	{
    		roomrepository.updateInformation(infor,hotel_name,roomnum);
    		return "updated Complete";
    	}		
	}
}
