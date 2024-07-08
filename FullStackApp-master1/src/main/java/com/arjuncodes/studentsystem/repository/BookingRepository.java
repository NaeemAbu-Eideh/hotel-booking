package com.arjuncodes.studentsystem.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.Booking;
import com.arjuncodes.studentsystem.model.Request;

public interface BookingRepository extends JpaRepository<Booking, Long> 
{
	@Query(value = "SELECT * FROM Booking u WHERE u.person_name = :person_name and u.person_email LIKE :person_email and u.hotel_name LIKE :hotel_name and u.roomnum = :roomnum",   nativeQuery = true)	
	public List<Booking> findBooking(
    @Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Query(value = "SELECT * FROM Booking u WHERE u.person_name = :person_name and u.person_email LIKE :person_email and u.hotel_name LIKE :hotel_name and u.roomnum = :roomnum and u.start_date = :start_date and u.end_date = :end_date",   nativeQuery = true)	
	public List<Booking> findBooking2(
    @Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum,@Param("start_date")LocalDate start_date,@Param("end_date")LocalDate end_date);
	
	@Modifying
	@Query(value = "Delete  FROM Booking  WHERE person_name = :person_name and person_email LIKE :person_email and hotel_name LIKE :hotel_name and roomnum = :roomnum",   nativeQuery = true)	
	void deleteBooking(@Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum);
	
	@Modifying
	@Query("UPDATE FROM Booking SET accepted =:accepted Where person_name = :person_name and person_email LIKE :person_email and hotel_name LIKE :hotel_name and roomnum = :roomnum and start_date = :start_date and end_date = :end_date")
	void updateAccepted(@Param("person_name") String person_name,@Param("person_email") String person_email, @Param("hotel_name") String hotel_name,@Param("roomnum") long roomnum,@Param ("accepted")String accepted,@Param("start_date")LocalDate start_date,@Param("end_date")LocalDate end_date);
	
	@Modifying
	@Query("UPDATE FROM Booking SET accepted =:accepted Where id =:id")
	void updateAccepted1(@Param("accepted")String accepted,@Param("id")long id);
}
