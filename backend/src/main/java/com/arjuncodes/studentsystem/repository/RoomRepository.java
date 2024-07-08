package com.arjuncodes.studentsystem.repository;

import java.util.List;

import javax.persistence.Table;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.model.Room;

public interface RoomRepository extends JpaRepository<Room, Long> 
{
	@Query(value = "SELECT * FROM Room u WHERE u.roomnum = :roomnum and u.hotel_name LIKE :hotel_name",   nativeQuery = true)
	List<Room> findRoom(
    @Param("roomnum") long roomnum, @Param("hotel_name") String hotel_name);
		
	@Modifying
	@Query("UPDATE FROM Room SET reserved =:reserved Where hotel_name =:hotel_name and roomnum = :roomnum")
	void updateRoom(@Param("reserved") String reserved,@Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Modifying
	@Query("UPDATE FROM Room SET infor =:infor Where roomnum = :roomnum and hotel_name =:hotel_name")
	void updateInformation(@Param("infor") String infor,@Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Modifying
	@Query(value = "Delete FROM Room Where hotel_name LIKE :hotel_name and roomnum = :roomnum", nativeQuery = true)	
	void deleteRoom(@Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
		
}
