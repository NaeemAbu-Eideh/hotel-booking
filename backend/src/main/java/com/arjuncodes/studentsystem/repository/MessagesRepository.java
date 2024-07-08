package com.arjuncodes.studentsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.Messages;

public interface MessagesRepository extends JpaRepository<Messages, Long> 
{
	@Query(value ="SELECT * from Messages  Where send_from_email LIKE :send_from_email and send_to_email = :send_to_email and title = :title and body = :body ",nativeQuery = true)
	public List<Messages> findMessages(@Param("send_from_email") String send_from_email,@Param("send_to_email") String send_to_email,@Param("title") String title ,@Param("body") String body);
	
@Modifying
@Query("Delete from Messages Where send_from_email LIKE :send_from_email and send_to_email = :send_to_email and title = :title and body = :body ")
public void deleteMessages(@Param("send_from_email") String send_from_email,@Param("send_to_email") String send_to_email,@Param("title") String title ,@Param("body") String body);

@Modifying
@Query("update from Messages set type =:type Where send_from_email LIKE :send_from_email and send_to_email = :send_to_email and title = :title and body = :body ")
public void updatetype(@Param("type")String type,@Param("send_from_email") String send_from_email,@Param("send_to_email") String send_to_email,@Param("title") String title ,@Param("body") String body);
}
