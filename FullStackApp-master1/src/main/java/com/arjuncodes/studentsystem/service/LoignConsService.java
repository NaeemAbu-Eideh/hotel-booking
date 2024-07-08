package com.arjuncodes.studentsystem.service;

import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Country;
import com.arjuncodes.studentsystem.model.Hotel;

public interface LoignConsService
{
    public Cons saveCons(Cons cons);
    public List<Cons> getAllCons();
    public String deleteCons(String email);
    public Cons FindCons(String email);
    public String updateFname(String email,String Fname);
    public String updateLname(String email,String Lname);
    public String updatePass(String email,String pass);
    public Cons updateLoginCons (Cons cons); 
    public String FindCons(String email,String pass);
    public List<Cons> FindConsep(String email,String pass);
    public String Find(String email);
    public List<Cons> Finde(String email);
    public String FindPass(String email,long phonenum);
    public String updatePhonenum(String email,long phonenum);
    public String getPhonenum(long phonenum);
}
