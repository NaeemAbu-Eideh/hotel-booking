 package com.arjuncodes.studentsystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.Cons;
import com.arjuncodes.studentsystem.service.LoignConsService;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/logincons")
public class LoginConsController {
	@Autowired
	private LoignConsService loginconsservice;
	
	
	@PostMapping("/add")
    public String add(@RequestBody Cons cons){
		loginconsservice.saveCons(cons);
        return "New login is added";
    }

    @GetMapping("/get")
    public List<Cons> list(){
        return loginconsservice.getAllCons();
    }
    @GetMapping("/findep")
    public String FindCons(String email,String pass)
    {
    	 if(loginconsservice.FindCons(email, pass)!=null)
    		 return "founded";
    	 else
	    		return null;
    }
    @GetMapping("/getep")
    public List<Cons> FindConsep(String email,String pass)
    {
    	 if(loginconsservice.FindCons(email, pass)!=null)
    		 return loginconsservice.FindConsep(email, pass);
    	 else
	    		return null;
    }
   
    @DeleteMapping("/delete")
    public String deleteCons(@RequestParam String email)
    {
    	if(loginconsservice.deleteCons(email)!=null)
    	return "Cons Deleted";
    	else
    		return null;
    }
    
    @GetMapping("/find")
    public String Find( String email )
    {
    	if(loginconsservice.Find(email)==null)
    		return null;
    	else
    		return "founded";
    }
    @GetMapping("/gete")
    public List<Cons> Finde( String email )
    {
    	if(loginconsservice.Finde(email)==null)
    		return null;
    	else
    		return loginconsservice.Finde(email);
    }
    @GetMapping("/findpass")
    public String FindPass(String email,long phonenum)
    {
    	if(loginconsservice.FindPass(email, phonenum)!=null)
    		return loginconsservice.FindPass(email, phonenum);
    	else
    		return "not founded";
    }
    
    @PutMapping("/update")
    public String updateLoginCons(@RequestBody Cons cons)
    {
    	try
    	{
    	loginconsservice.saveCons(cons);
    	return "update succesfully";
    	}
    	catch (Exception e)
    	{
    		System.out.print(e);
    		return "cannot update";
    	}
    }
    @PutMapping("/updatefname")
    public String updateFname(String email,String fname)
    {
    	if(loginconsservice.updateFname(email, fname)!=null)
    		return "Updated Completed";
    	else
    		return null;
    }
    @PutMapping("/updatelname")
    public String updateLname(String email,String lname)
    {
    	if(loginconsservice.updateLname(email, lname)!=null)
    		return "Updated Completed";
    	else
    		return null;
    }
    @PutMapping("/updatepass")
    public String updatePass(String email,String pass)
    {
    	if(loginconsservice.updatePass(email, pass)!=null)
    		return "Updated Completed";
    	else
    		return null;
    }
    @PutMapping("/updatephonenum")
    public String updatePhonenum(String email,long phonenum)
    {
    	if(loginconsservice.updatePhonenum(email, phonenum)!=null)
    		return "Updated Completed";
    	else
    		return null;
    }
    @GetMapping("/getphonenum")
    public String getPhonenum(long phonenum)
    {
    	if(loginconsservice.getPhonenum(phonenum)!=null)
    		return "founded"; 
    	else
    		return null;
    }
}

