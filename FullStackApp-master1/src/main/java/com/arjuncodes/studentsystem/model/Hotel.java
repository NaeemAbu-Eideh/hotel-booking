package com.arjuncodes.studentsystem.model;

import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.lang.Nullable;
@Entity
@Table
public class Hotel 
{

	@Id
	private String name;
	private String informartion;
	private String lon,lat;
	private double totrate;
	private double numrate;
	
	@ManyToOne()
	@JoinColumn(nullable  = false)
	private City city;
	
	
	private double rate;
		
	@OneToMany(mappedBy = "hotel",cascade = CascadeType.REMOVE)
	   private List<Room> room;
	
	@OneToMany(mappedBy = "hotel",cascade = CascadeType.REMOVE)
	private List<Request>request;
	
	@OneToMany(mappedBy = "hotel",cascade = CascadeType.REMOVE)
	private List<Booking>booking;
	
	@OneToMany(mappedBy = "hotel",cascade = CascadeType.REMOVE)
	private List<Acceptrequest>acceptrequest;
	
	@OneToMany(mappedBy = "hotel",cascade = CascadeType.REMOVE)
	private List<Imagehotel>imagehotel;
	
	@OneToMany(mappedBy = "hotel",cascade = CascadeType.REMOVE)
	private List<Imageroom>imageroom;
	 
	public Hotel() 
	{
		super();
		// TODO Auto-generated constructor stub
	}
	public Hotel(String name,City city, String informartion,String lon,String lat,double rate,byte[]image,String imagename,double totrate,double numrate) {
		super();
		this.name = name;
		this.city = city;
		this.informartion = informartion;
		this.lon = lon;
		this.lat = lat;
		this.rate = rate;
		this.numrate = numrate;
		this.totrate = totrate;


	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
	}
	public String getInformartion() {
		return informartion;
	}
	public void setInformation(String informartion) {
		this.informartion = informartion;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLat() {
		return lat;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public double getRate() {
		return rate;
	}
	public double getNumrate() {
		return numrate;
	}

	public void setNumrate(double numrate) {
		this.numrate = numrate;
	}

	public void setTotrate(long numrate) {
		this.numrate = numrate;
	}
	public double getTotrate() {
		return totrate;
	}
}
