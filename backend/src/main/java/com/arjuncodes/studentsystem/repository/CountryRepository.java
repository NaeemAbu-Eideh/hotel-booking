package com.arjuncodes.studentsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.arjuncodes.studentsystem.model.Country;

public interface CountryRepository extends JpaRepository<Country, String> 
{
	@Query("select coun from Country coun where coun.name =:namebind")
	public List<Country> FindCountry (@Param ("namebind") String name);
	
	@Modifying
	@Query("UPDATE FROM Country  SET rate =:rate WHERE name = :name")
	void updateRate(@Param("rate") double rate,@Param("name") String name);
	
	@Modifying
	@Query("UPDATE FROM Country  SET numrate =:numrate WHERE name = :name")
	void updateNumrate(@Param("numrate") double numrate,@Param("name") String name);
	
	@Modifying
	@Query("UPDATE FROM Country  SET totrate =:totrate WHERE name = :name")
	void updateTotrate(@Param("totrate") double totrate,@Param("name") String name);
	
	}
