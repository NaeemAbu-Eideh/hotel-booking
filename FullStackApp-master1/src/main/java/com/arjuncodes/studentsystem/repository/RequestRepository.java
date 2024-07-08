package com.arjuncodes.studentsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.Request;
import com.arjuncodes.studentsystem.model.Room;

public interface RequestRepository extends JpaRepository<Request, Long>
{
	@Query(value = "SELECT * FROM Request u WHERE u.person_name = :person_name and u.person_email = :person_email and u.hotel_name LIKE :hotel_name and u.roomnum = :roomnum",   nativeQuery = true)
	public List<Request> findRequest(
    @Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name , @Param ("roomnum") long roomnum);
	
	@Modifying
	@Query(value = "Delete  FROM Request  WHERE person_name = :person_name and person_email LIKE :person_email and hotel_name LIKE :hotel_name and roomnum = :roomnum",   nativeQuery = true)	
	void deleteRequest(@Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
}
