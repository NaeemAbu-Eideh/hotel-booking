package com.arjuncodes.studentsystem.service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.arjuncodes.studentsystem.model.Hotel;
import com.arjuncodes.studentsystem.model.Imagehotel;
import com.arjuncodes.studentsystem.model.Imageroom;
import com.arjuncodes.studentsystem.repository.ImagehotelRepository;
import com.arjuncodes.studentsystem.repository.ImageroomRepository;

import Image.Image;

@Service
public class ImageroomService {
	
	@Autowired
    private ImageroomRepository imageRepo;
	
	
	public String uploadImage(MultipartFile file,Hotel hotel,long roomnum) throws IOException 
	{		
		try
		{
		Imageroom pImage = new Imageroom();
		pImage.setName(file.getOriginalFilename());
		pImage.setType(file.getContentType());
		pImage.setImageData(Image.compressImage(file.getBytes()));
        pImage.setHotel(hotel);
        pImage.setRoom(roomnum);
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
        Optional<Imageroom> imageData = imageRepo.findByName(fileName);
        return Image.decompressImage(imageData.get().getImageData());
    }
	
	public byte[] findImageroom(String name,String hotel_name,long roomnum)
	{
			Optional<Imageroom> imageData = imageRepo.findImageroom1(name, hotel_name,roomnum);
			if(imageRepo.findImageroom(name, hotel_name,roomnum).isEmpty())
				return null;
			else
				return Image.decompressImage(imageData.get().getImageData());
	}
	public List<Imageroom> getAllImage()
	{
		return imageRepo.findAll();
	}
}
