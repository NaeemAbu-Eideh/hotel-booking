     package com.arjuncodes.studentsystem.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Hotel;

public interface LoginHotelRepository extends JpaRepository<Hotel, String> 
{
	@Query(value = "SELECT * FROM Hotel u WHERE u.name = :name",   nativeQuery = true)
	List<Hotel> findHotel(
    @Param("name") String name);
	
	@Query(value = "SELECT * FROM Hotel u WHERE u.name = :name and u.city_name LIKE :city_name",   nativeQuery = true)
	List<Hotel> findHotel(
    @Param("name") String name, @Param("city_name") String city_name);
	
	@Modifying
	@Query("UPDATE FROM Hotel  SET informartion =:informartion WHERE name = :name and city_name LIKE :city_name ")
	void updateInformartion(@Param("informartion") String informartion,@Param("name") String name, @Param("city_name") String city_name);
	
	@Modifying
	@Query("UPDATE FROM Hotel  SET rate =:rate WHERE name = :name")
	void updateRate(@Param("rate") double rate,@Param("name") String name);
	
	@Modifying
	@Query("UPDATE FROM Hotel  SET numrate =:numrate WHERE name = :name")
	void updateNumrate(@Param("numrate") double numrate,@Param("name") String name);
	
	@Modifying
	@Query("UPDATE FROM Hotel  SET totrate =:totrate WHERE name = :name")
	void updateTotrate(@Param("totrate") double totrate,@Param("name") String name);

Optional<Hotel> findByName(String fileName);

}
