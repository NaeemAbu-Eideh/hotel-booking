package com.arjuncodes.studentsystem.model;

import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.lang.Nullable;

@Entity
@Table(name = "country")
public class Country 
{
   @Id
   @Column(name = "name")
   private String name;
   private double rate;
   private double totrate;
   private double numrate;
   
   @OneToMany(mappedBy = "country",cascade = CascadeType.REMOVE)
   private List<City> city;
   
   

   
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
public Country() {
	super();
	// TODO Auto-generated constructor stub
}
public Country(String name, int rate,long totrate,long numrate) {
	super();
	this.name = name;
	this.rate = rate;
	this.numrate = numrate;
	this.totrate = totrate;
}
}
