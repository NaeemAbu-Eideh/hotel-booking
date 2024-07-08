package com.arjuncodes.studentsystem.model;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table
@Entity
public class Acceptrequest
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
	
	@ManyToOne()
	@JoinColumn(nullable  = false)
	private Hotel hotel;
	
	@ManyToOne()
	@JoinColumn(nullable  = false)
	private Cons person;
	
	private long roomnum;
	
    private String person_name;
	
	private LocalDate start_date ;
	private LocalDate end_date;
	
	private double total_price;
	
	public String accepted;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Hotel getHotel() {
		return hotel;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	public Cons getPerson() {
		return person;
	}

	public void setPerson(Cons person) {
		this.person = person;
	}

	public long getRoomnum() {
		return roomnum;
	}

	public void setRoomnum(long roomnum) {
		this.roomnum = roomnum;
	}

	public String getPerson_name() {
		return person_name;
	}

	public void setPerson_name(String person_name) {
		this.person_name = person_name;
	}

	public LocalDate getStart_date() {
		return start_date;
	}

	public void setStart_date(LocalDate start_date) {
		this.start_date = start_date;
	}

	public LocalDate getEnd_date() {
		return end_date;
	}

	public void setEnd_date(LocalDate end_date) {
		this.end_date = end_date;
	}

	public double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(double total_price) {
		this.total_price = total_price;
	}
	public String getAccepted()
	{
		return accepted;
	}
	public void setAccepted(String accepted)
	{
		this.accepted=accepted;
	}
	public Acceptrequest() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Acceptrequest(long id, Hotel hotel, Cons person, long roomnum, String person_name, LocalDate start_date,
			LocalDate end_date, double total_price,String accepted) {
		super();
		this.id = id;
		this.hotel = hotel;
		this.person = person;
		this.roomnum = roomnum;
		this.person_name = person_name;
		this.start_date = start_date;
		this.end_date = end_date;
		this.total_price = total_price;
		this.accepted = accepted;
	}

}
