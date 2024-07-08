package com.arjuncodes.studentsystem.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.model.Imageroom;
import com.arjuncodes.studentsystem.service.ImagehotelService;
import com.arjuncodes.studentsystem.service.ImageroomService;

@RestController
@RequestMapping("/imageroom")
public class ImageroomController {
	
	@Autowired
	private ImageroomService productImageService;
	
	@ResponseStatus(value = HttpStatus.OK)
	@PostMapping("/add")
	public String uploadImage(@RequestParam("image")MultipartFile file,@RequestParam("hotel_name") Hotel hotel,@RequestParam ("roomnum") long roomnum) throws IOException 
	{
		if(productImageService.uploadImage(file,hotel,roomnum)!=null)
			return "saved successfully";
		else
			return "Cannot Save";
			
	}
	
	@GetMapping("/get/{fileName}")
	public ResponseEntity<byte[]> downloadImage(@PathVariable String fileName) {
		byte[] image = productImageService.downloadImage(fileName);
		return ResponseEntity.status(HttpStatus.OK).contentType(MediaType.valueOf("image/png")).body(image);
	}
	
	@GetMapping("/get/{fileName}/{hotel_name}/{roomnum}")
	public ResponseEntity<byte[]> downloadImage(@PathVariable String fileName,@PathVariable String hotel_name,@PathVariable long roomnum )
	{
		if(productImageService.findImageroom(fileName, hotel_name,roomnum)!=null)
		{
		byte[] image = productImageService.findImageroom(fileName, hotel_name,roomnum);
		return ResponseEntity.status(HttpStatus.OK).contentType(MediaType.valueOf("image/png")).body(image);
		}
		else
			return null;
	}
	@GetMapping("/get")
	public List<Imageroom> getAllImage()
	{
		return productImageService.getAllImage();
	}
	@GetMapping("/find/{fileName}/{hotel_name}/{roomnum}")
	public byte[] download(@PathVariable String fileName,@PathVariable String hotel_name,@PathVariable long roomnum )
	{
		if(productImageService.findImageroom(fileName, hotel_name,roomnum)!=null)
		{
		byte[] image = productImageService.findImageroom(fileName, hotel_name,roomnum);
		return image;
		}
		else
			return null;
	}
}
