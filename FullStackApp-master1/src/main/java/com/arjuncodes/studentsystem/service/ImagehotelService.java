package com.arjuncodes.studentsystem.service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.model.Imagehotel;


import com.arjuncodes.studentsystem.repository.ImagehotelRepository;

import Image.Image;

@Service
public class ImagehotelService {
	
	@Autowired
    private ImagehotelRepository imageRepo;
	
	
	public String uploadImage(MultipartFile file,Hotel hotel) throws IOException 
	{		
		try
		{
		Imagehotel pImage = new Imagehotel();
		pImage.setName(file.getOriginalFilename());
		pImage.setType(file.getContentType());
		pImage.setImageData(Image.compressImage(file.getBytes()));
        pImage.setHotel(hotel);
        imageRepo.save(pImage);
		return "saved successfully";
		}
		catch(Exception e)
		{
			System.out.print(e);
			return null;
		}
		
	}
	
	public byte[] downloadImage(String fileName)
	{
        Optional<Imagehotel> imageData = imageRepo.findByName(fileName);
        return Image.decompressImage(imageData.get().getImageData());
    }
	
	public byte[] findImagehotel(String name,String hotel_name)
	{
			Optional<Imagehotel> imageData = imageRepo.findImagehotel1(name, hotel_name);
			if(imageRepo.findImagehotel(name, hotel_name).isEmpty())
				return null;
			else
				return Image.decompressImage(imageData.get().getImageData());
	}
	public List<Imagehotel> getAllImages ()
	{
	return	imageRepo.findAll();
	}
	}
