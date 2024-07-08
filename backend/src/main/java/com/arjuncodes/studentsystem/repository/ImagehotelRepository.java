package com.arjuncodes.studentsystem.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.Imagehotel;
import com.arjuncodes.studentsystem.model.Request;


public interface ImagehotelRepository extends JpaRepository<Imagehotel,String>
{
	@Query(value = "SELECT * FROM Imagehotel u WHERE u.name = :name and u.hotel_name LIKE :hotel_name",   nativeQuery = true)
	public List<Imagehotel> findImagehotel(
    @Param("name") String name,@Param("hotel_name") String hotel_name);
	
	@Query(value = "SELECT * FROM Imagehotel u WHERE u.name = :name and u.hotel_name LIKE :hotel_name",   nativeQuery = true)
    Optional<Imagehotel> findImagehotel1(
    @Param("name") String name,@Param("hotel_name") String hotel_name);
	
    Optional<Imagehotel> findByName(String name);

}
