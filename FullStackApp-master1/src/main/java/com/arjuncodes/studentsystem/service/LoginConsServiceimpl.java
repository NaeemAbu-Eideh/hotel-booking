package com.arjuncodes.studentsystem.service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.model.Country;
import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.repository.LoginConsRepository;

import Image.Image;



@Service
public class LoginConsServiceimpl implements LoignConsService
{

    @Autowired
    private LoginConsRepository loginconsrepository;

    @Override
    public Cons saveCons(Cons cons) {
        return loginconsrepository.save(cons);
    }

    @Override
    public List<Cons> getAllCons() 
    {
        return loginconsrepository.findAll();
    }
   
    @Override
     public String deleteCons(String email)
    {
    	if(loginconsrepository.findById(email).isEmpty())
    		return null;
    	else
    	{
    	loginconsrepository.deleteById(email);
    	return "Deleted Complete";
    }
    }
    @Override
    public Cons FindCons(String email)
    {
    	if(loginconsrepository.findById(email).isEmpty())
    		return null;
    	else
    	return loginconsrepository.findById(email).get();
    }
    
    @Override
    public Cons updateLoginCons (Cons cons)
    {
    	return loginconsrepository.save(cons);
    }
    @Override
    public String FindCons(String email,String pass)
    {
    	if(loginconsrepository.FindCons(email, pass).isEmpty())
    		return null;
    		else
    			return  "founded";
    }
    @Override
    public List<Cons> FindConsep(String email,String pass)
    {
    	if(loginconsrepository.FindCons(email, pass).isEmpty())
    		return null;
    		else
    		return loginconsrepository.FindCons(email, pass);
    }
    @Override
    public String Find(String email)
    {
    	if(loginconsrepository.Find(email).isEmpty())
    		return null;
    		else
    			return  "founded";
    }
    @Override
    public List<Cons> Finde(String email)
    {
    	if(loginconsrepository.Find(email).isEmpty())
    		return null;
    		else
    		return loginconsrepository.Find(email);
    }
    @Override
    public String FindPass(String email,long phonenum)
    {
    	if(loginconsrepository.FindPass(email, phonenum).isEmpty())
    		return null;
    		else
    		{
    			return loginconsrepository.getById(email).getPass();
    		}
   	}
    @Transactional
    @Override
    public String updateFname(String email,String Fname)
    {
    	if(loginconsrepository.Find(email).isEmpty())
    		return null;
    	else
    		loginconsrepository.updateFname(Fname,email);
    	return "Updated Completed";
    }
    @Transactional
    @Override
    public String updateLname(String email,String Lname)
    {
    	if(loginconsrepository.Find(email).isEmpty())
    		return null;
    	else
    		loginconsrepository.updateLname(Lname,email);
    	return "Updated Completed";
    }
    @Transactional
    @Override
    public String updatePass(String email,String pass)
    {
    	if(loginconsrepository.Find(email).isEmpty())
    		return null;
    	else
    		loginconsrepository.updatePass(pass,email);
    	return "Updated Completed";
    }
    @Transactional
    @Override
    public String updatePhonenum(String email,long phonenum)
    {
    	if(loginconsrepository.Find(email).isEmpty())
    		return null;
    	else
    		loginconsrepository.updatePhonenum(phonenum,email);
    	return "Updated Completed";
    }
    @Override
    public String getPhonenum(long phonenum)
    {
    	if(loginconsrepository.getPhonenum(phonenum).isEmpty())
    		return null;
    	else
    		return "founded";
    }
}
