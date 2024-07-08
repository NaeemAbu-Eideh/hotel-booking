package com.arjuncodes.studentsystem.model;

import java.sql.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Table
@Entity
public class City
{
@Id
private String name;
private double rate;
private double totrate;
private double numrate;

@ManyToOne()
@JoinColumn(nullable  = false)
private Country country;

@OneToMany(mappedBy = "city",cascade = CascadeType.REMOVE)
private List<Hotel> hotel;

public City(String name, double rate, Country country,long totrate,long numrate) {
	super();
	this.name = name;
	this.rate = rate;
	this.country = country;
	this.numrate = numrate;
	this.totrate = totrate;
}

public City() {
	super();
	// TODO Auto-generated constructor stub
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public double getRate() {
	return rate;
}

public void setRate(double rate) {
	this.rate = rate;
}
public double getNumrate() {
	return numrate;
}

public void setNumrate(double numrate) {
	this.numrate = numrate;
}

public void setTotrate(double numrate) {
	this.numrate = numrate;
}
public double getTotrate() {
	return totrate;
}

public Country getCountry() {
	return country;
}

public void setCountry(Country country) {
	this.country = country;
}
}
