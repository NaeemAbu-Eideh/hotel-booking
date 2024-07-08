package com.arjuncodes.studentsystem.service;

import java.util.List;

import javax.persistence.Table;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Room;

public interface RoomService 
{
	public Room saveRoom(Room room);
	public List<Room> getAllRoom();
	public String deleteRoom (String hotel_name,int roomnum);
	public String FindRoom(int roomnum,String hotel_name);
	public List<Room> getRoom(int roomnum,String hotel_name);
	public String updateReserved(long roomnum,String hotel_name,String reserved);
    public String updateInformation(long roomnum,String hotel_name,String infor);


}
