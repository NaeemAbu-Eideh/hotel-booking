package com.arjuncodes.studentsystem.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Hotel;

public interface LoginConsRepository extends JpaRepository<Cons,String> 
{
	@Query("select con from Cons con where con.email =:emailbind and con.pass =:passbind")
	public List <Cons> FindCons (@Param("emailbind") String email,@Param("passbind") String pass);
	
	@Query("select con from Cons con where con.email =:emailbind")
	public List <Cons> Find (@Param("emailbind") String email);
	
	@Query("select con from Cons con where con.email =:emailbind and con.phonenum =:phonenumbind")
	public List <Cons> FindPass (@Param("emailbind") String email,@Param("phonenumbind") long phonenum);
	
	@Query("select con from Cons con where con.phonenum =:phonenum")
	public List<Cons> getPhonenum(@Param("phonenum") long phonenum);
	
	@Modifying
	@Query("UPDATE FROM Cons u SET u.Fname =:Fname Where u.email =:email")
	void updateFname(@Param("Fname") String fname,@Param("email") String email);
	
	@Modifying
	@Query("UPDATE FROM Cons u SET u.Lname =:Lname Where u.email =:email")
	void updateLname(@Param("Lname") String Lname,@Param("email") String email);
	
	@Modifying
	@Query("UPDATE FROM Cons u SET u.pass =:pass Where u.email =:email")
	void updatePass(@Param("pass") String pass,@Param("email") String email);
	
	@Modifying
	@Query("UPDATE FROM Cons u SET u.phonenum =:phonenum Where u.email =:email")
	void updatePhonenum(@Param("phonenum") long phonenum,@Param("email") String email);

}

