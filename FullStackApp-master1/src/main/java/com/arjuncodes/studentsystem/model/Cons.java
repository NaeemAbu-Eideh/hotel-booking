package com.arjuncodes.studentsystem.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table
public class Cons {

	@Id
    private String email;
	private String Fname;
	private String Lname;
	private String pass;
	@Column(unique = true)
	private long phonenum;
	private String type;
	
	 @OneToMany(mappedBy = "person",cascade = CascadeType.REMOVE)
	   private List<Request> request;
	 
	 @OneToMany(mappedBy = "person",cascade = CascadeType.REMOVE)
	   private List<Booking> booking;
	 
	 @OneToMany(mappedBy = "person",cascade = CascadeType.REMOVE)
	   private List<Acceptrequest> acceptrquest;
	 
	 @OneToMany(mappedBy = "send_from",cascade = CascadeType.REMOVE)
	   private List<Notification> notification;
	 
	 @OneToMany(mappedBy = "send_to",cascade = CascadeType.REMOVE)
	   private List<Notification> notification1;
	 
	public Cons(String email, String Fname,String Lname, String pass,long phonenum, String type) {
		super();
		this.email = email;
		this.Fname = Fname;
		this.Lname = Lname;
		this.pass = pass;
		this.phonenum = phonenum;
		this.type = type;
	}
	public Cons() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFName() {
		return Fname;
	}
	public String getLName() {
		return Lname;
	}
	public void setFName(String Fname) {
		this.Fname = Fname;
	}
	public void setLName(String Lname) {
		this.Lname = Lname;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public long getPhonenum() {
		return phonenum;
	}
	public void setPhonenum(long phonenum) {
		this.phonenum = phonenum;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	}



