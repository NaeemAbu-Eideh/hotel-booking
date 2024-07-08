package com.arjuncodes.studentsystem.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table
@Entity
public class Room {
	
@Id
@GeneratedValue(strategy = GenerationType.AUTO)
private long id;

@ManyToOne()
@JoinColumn(nullable = false)
private Hotel hotel;

private long roomnum;
private String infor;
private String type;
private String ifseparated;
private String sweet;
private String bed;
private int price;
private String reserved;
public Room() {
	super();
	// TODO Auto-generated constructor stub
}
public Room(long id, Hotel hotel, int roomnum, String infor, String type,String ifseparated,String sweet,String bed, int price, String reserved) {
	super();
	this.id = id;
	this.hotel = hotel;
	this.roomnum = roomnum;
	this.infor = infor;
	this.type = type;
	this.ifseparated = ifseparated;
	this.sweet = sweet;
	this.bed = bed;
	this.price = price;
	this.reserved = reserved;
}
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
public long getRoomnum() {
	return roomnum;
}
public void setRoomnum(long roomnum) {
	this.roomnum = roomnum;
}
public String getInfor() {
	return infor;
}
public void setInfor(String infor) {
	this.infor = infor;
}
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}
public int getPrice() {
	return price;
}
public void setPrice(int price) {
	this.price = price;
}
public String getReserved() {
	return reserved;
}
public void setReserved(String reserved) {
	this.reserved = reserved;
}
public String getIfseparated() {
	return ifseparated;
}
public void setIfseparated(String ifseparated) 
{
	this.ifseparated = ifseparated;
}
public String getSweet() {
	return sweet;
}
public void setSweet(String sweet) 
{
	this.sweet = sweet;
}
public String getBed() {
	return bed;
}
public void setBed(String bed)
{
	this.bed = bed;
}
}
