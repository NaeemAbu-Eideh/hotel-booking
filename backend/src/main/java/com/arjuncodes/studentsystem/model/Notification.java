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
public class Notification 
{
@Id
@GeneratedValue(strategy = GenerationType.AUTO)
private long id;

private String title;
private String body;

@ManyToOne()
@JoinColumn(nullable  = false)
private Cons send_from;

@ManyToOne()
@JoinColumn(nullable  = false)
private Cons send_to;

private String type;
private LocalDate date ;
private String time;
private String houre;

public long getId() {
	return id;
}

public void setId(long id) {
	this.id = id;
}

public String getTitle() {
	return title;
}

public void setTitle(String title) {
	this.title = title;
}

public String getBody() {
	return body;
}

public void setBody(String body) {
	this.body = body;
}

public Cons getSend_from() {
	return send_from;
}

public void setSend_from(Cons send_from) {
	this.send_from = send_from;
}

public Cons getSend_to() {
	return send_to;
}

public void setSend_to(Cons send_to) {
	this.send_to = send_to;
}

public String getType() {
	return type;
}

public void setType(String type) {
	this.type = type;
}
public LocalDate getDate()
{
	return date;
}
public void setDate(LocalDate date)
{
	this.date = date;
}
public void setTime(String time)
{
	this.time = time;
}
public String getTime()
{
	return time;
}
public void setHoure(String houre)
{
	this.houre = houre;
}
public String getHoure()
{
	return houre;
}
public Notification() {
	super();
	// TODO Auto-generated constructor stub
}

public Notification(long id, String title, String body, Cons send_from, Cons send_to, String type) {
	super();
	this.id = id;
	this.title = title;
	this.body = body;
	this.send_from = send_from;
	this.send_to = send_to;
	this.type = type;
}
}
