package com.arjuncodes.studentsystem.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.xml.crypto.Data;

import java.time.LocalDate;
import java.util.Date;  


@Table
@Entity
public class Request 
{
@Id
@GeneratedValue(strategy = GenerationType.AUTO)
private long id;

private String person_name;

@ManyToOne()
@JoinColumn(nullable  = false)
private Hotel hotel;

@ManyToOne()
@JoinColumn(nullable  = false)
private Cons person;

private long roomnum;

private LocalDate start_date ;
private LocalDate end_date;

public Request() {
	super();
}
public Request(long id, String person_name, Hotel hotel, Cons person, long roomnum, LocalDate start_date, LocalDate end_date) {
	super();
	this.id = id;
	this.person_name = person_name;
	this.hotel = hotel;
	this.person = person;
	this.roomnum = roomnum;
	this.start_date = start_date;
	this.end_date = end_date;
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public String getPerson_name() {
	return person_name;
}
public void setPerson_name(String person_name) {
	this.person_name = person_name;
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
}
