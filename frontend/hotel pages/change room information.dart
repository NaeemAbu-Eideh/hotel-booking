import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../notification/notification_service.dart';

class ChangeRoomInformationPage extends StatefulWidget {
  const ChangeRoomInformationPage({super.key});

  @override
  State<ChangeRoomInformationPage> createState() => _ChangeRoomInformationPageState();
}

class _ChangeRoomInformationPageState extends State<ChangeRoomInformationPage> {
  TextEditingController roomNumber = TextEditingController();
  TextEditingController information = TextEditingController();
  TextEditingController numberOfRooms = TextEditingController();
  TextEditingController price = TextEditingController();
  String? highClass;
  String? roomType;
  String? bed;
  String? separated;
  int index = 0;
  int count = 0;
  int counter = 1;

  File? image;
  ImagePicker imagepicker = ImagePicker();
  uploadPhotoFromGallery()async{
    var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    image = File(pickedImage!.path);
    print("image: $image");
  }
  Timer? timer;
  Future startTimer()async{}

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "room information",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/page.jpg"),
                fit: BoxFit.fill
            )
        ),
        child: ListView(
          children: [
            const SizedBox(height: 60,),
            Container(
              padding: const EdgeInsets.only(right: 20,left: 10),
              child: TextFormField(
                controller: numberOfRooms,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.numbers),
                  label: Text(
                    "number of rooms",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(right: 20,left: 10),
              child: TextFormField(
                controller: roomNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.numbers),
                  label: Text(
                    "room number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const SizedBox(width: 50,),
                const Text(
                  "regular",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "regular", groupValue: highClass, onChanged: (index){
                  setState(() {
                    highClass = index;
                  });
                }),
                const SizedBox(width: 20,),
                const Text(
                  "vip",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "vip", groupValue: highClass, onChanged: (index){
                  setState(() {
                    highClass = index;
                  });
                }),
                const SizedBox(width: 20,),
                const Text(
                  "vvip",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "vvip", groupValue: highClass, onChanged: (index){
                  setState(() {
                    highClass = index;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "if vip or vvip: ",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 50,),
                const Text(
                  "sweet",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "sweet", groupValue: roomType, onChanged: (index){
                  setState(() {
                    roomType = index;
                  });
                }),
                const SizedBox(width: 20,),
                const Text(
                  "regular",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "regular", groupValue: roomType, onChanged: (index){
                  setState(() {
                    roomType = index;
                  });
                }),

              ],
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "if sweet: ",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 50,),
                const Text(
                  "one bed",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "one bed", groupValue: bed, onChanged: (index){
                  setState(() {
                    bed = index;
                  });
                }),
                const SizedBox(width: 20,),
                const Text(
                  "two beds",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "two beds", groupValue: bed, onChanged: (index){
                  setState(() {
                    bed = index;
                  });
                }),

              ],
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "if two beds: ",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 50,),
                const Text(
                  "separated",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "separated", groupValue: separated, onChanged: (index){
                  setState(() {
                    separated = index;
                  });
                }),
                const SizedBox(width: 20,),
                const Text(
                  "regular",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "regular", groupValue: separated, onChanged: (index){
                  setState(() {
                    separated = index;
                  });
                }),

              ],
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(right: 20,left: 10),
              child: TextFormField(
                controller: information,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.info_outlined),
                  iconColor: Colors.black,
                  label: Text(
                    "some information about room",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(right: 20,left: 10),
              child: TextFormField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.numbers),
                  label: Text(
                    "room price",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 100,right: 100),
              child: ElevatedButton(
                onPressed: ()async{
                  await uploadPhotoFromGallery();
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),

                ),
                child: const Text(
                  "chose photos",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 190),
                  child: ElevatedButton(
                    onPressed: ()async{


                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),

                    ),
                    child: const Text(
                      "update",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: ()async{
                      Navigator.of(context).pop();
                      SuccessAlertBox(
                        context: context,
                        title: "Success",
                        messageText: "account has created",
                      );

                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),

                    ),
                    child: const Text(
                      "finish",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

