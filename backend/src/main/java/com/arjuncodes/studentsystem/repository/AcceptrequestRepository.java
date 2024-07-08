package com.arjuncodes.studentsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.Acceptrequest;
import com.arjuncodes.studentsystem.model.Booking;

public interface AcceptrequestRepository extends JpaRepository<Acceptrequest, Long> 
{
	@Query(value = "SELECT * FROM Acceptrequest u WHERE u.person_name = :person_name and u.person_email LIKE :person_email and u.hotel_name LIKE :hotel_name and u.roomnum = :roomnum",   nativeQuery = true)	
	public List<Acceptrequest> findAcceptrequest(
    @Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Modifying
	@Query(value = "Delete  FROM Acceptrequest  WHERE person_name = :person_name and person_email LIKE :person_email and hotel_name LIKE :hotel_name and roomnum = :roomnum",   nativeQuery = true)	
	void deleteAcceptrequest(@Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Modifying
	@Query("UPDATE FROM Acceptrequest SET accepted =:accepted Where person_name = :person_name and person_email LIKE :person_email and hotel_name LIKE :hotel_name and roomnum = :roomnum")
	void updateAccepted(@Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum,@Param ("accepted")String accepted);
}
