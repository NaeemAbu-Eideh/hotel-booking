package com.arjuncodes.studentsystem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.arjuncodes.studentsystem.model.Notification;

public interface NotificationRepository extends JpaRepository<Notification, Long>
{
	
	@Query(value ="SELECT * from Notification  Where send_from_email LIKE :send_from_email and send_to_email = :send_to_email and title = :title and body = :body and type = :type",nativeQuery = true)
	public List<Notification> findNotification(@Param("send_from_email") String send_from_email,@Param("send_to_email") String send_to_email,@Param("title") String title ,@Param("body") String body,@Param("type") String type);
	
@Modifying
@Query("Delete from Notification Where send_from_email LIKE :send_from_email and send_to_email = :send_to_email and title = :title and body = :body and type = :type")
public void deleteNotification(@Param("send_from_email") String send_from_email,@Param("send_to_email") String send_to_email,@Param("title") String title ,@Param("body") String body,@Param("type") String type);

}
