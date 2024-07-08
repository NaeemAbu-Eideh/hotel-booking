package com.arjuncodes.studentsystem.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.PostMapping;

import com.arjuncodes.studentsystem.model.Imagehotel;
import com.arjuncodes.studentsystem.model.Imageroom;
import com.arjuncodes.studentsystem.model.Room;


public interface ImageroomRepository extends JpaRepository<Imageroom,Long>
{
	@Query(value = "SELECT * FROM Imageroom u WHERE u.name = :name and u.roomnum = :roomnum and u.hotel_name LIKE :hotel_name",   nativeQuery = true)
	public List<Imageroom> findImageroom(
    @Param("name") String name,@Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Query(value = "SELECT * FROM Imageroom u WHERE u.name = :name and u.roomnum = :roomnum and u.hotel_name LIKE :hotel_name",   nativeQuery = true)
    Optional<Imageroom> findImageroom1(
    @Param("name") String name,@Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
    Optional<Imageroom> findByName(String name);

}
