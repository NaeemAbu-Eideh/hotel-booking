package com.arjuncodes.studentsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.arjuncodes.studentsystem.model.City;
import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Room;

public interface CityRepository extends JpaRepository<City, String>
{
	@Query("select cit from City cit where cit.name =:namebind")
	public List <City> Find (@Param("namebind") String name);
	
	@Query(value = "SELECT * FROM City u WHERE u.name = :name and u.country_name LIKE :country_name",   nativeQuery = true)
	List<City> findCity(
    @Param("name") String name, @Param("country_name") String country_name);
	
	@Modifying
	@Query("UPDATE FROM City  SET rate =:rate WHERE name = :name and country_name = :country_name")
	void updateRate(@Param("rate") double rate,@Param("name") String name,@Param("country_name") String country_name);
	
	@Modifying
	@Query("UPDATE FROM City  SET numrate =:numrate WHERE name = :name and country_name = :country_name")
	void updateNumrate(@Param("numrate") double numrate,@Param("name") String name,@Param("country_name") String country_name);
	
	@Modifying
	@Query("UPDATE FROM City  SET totrate =:totrate WHERE name = :name and country_name = :country_name")
	void updateTotrate(@Param("totrate") double totrate,@Param("name") String name,@Param("country_name") String country_name);
}
