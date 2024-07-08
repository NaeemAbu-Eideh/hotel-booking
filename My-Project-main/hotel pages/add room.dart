// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:image_picker/image_picker.dart';

import '../notification/notification_service.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  TextEditingController roomNumber = TextEditingController();
  TextEditingController information = TextEditingController();
  TextEditingController price = TextEditingController();
  String? highClass = "regular";
  String? roomType = "regular";
  String? bed = "one bed";
  String? separated = "regular";

  int count = 0;

  List images = [];
  ImagePicker imagePicker = ImagePicker();
  uploadPhotoFromGallery()async{
    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    images.add(pickedImage!.path);
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
                controller: roomNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.numbers),
                  label: Text(
                    "room number*",
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
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "high class: ",
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
                  "regular",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Radio(value: "regular", groupValue: highClass, onChanged: (index){
                  setState(() {
                    roomType = "regular";
                    bed = "one bed";
                    separated = "regular";
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
                    roomType = "regular";
                    bed = "one bed";
                    separated = "regular";
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
                    roomType = "regular";
                    bed = "one bed";
                    separated = "regular";
                    highClass = index;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
                child: highClass == "regular"? Container():Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 250),
                      child: const Text(
                        "room type: ",
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
                            bed = "one bed";
                            separated = "regular";
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
                            bed = "one bed";
                            separated = "regular";
                            roomType = index;
                          });
                        }),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(right: 300),
                      child: const Text(
                        "bed: ",
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
                            separated = "regular";
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
                            separated = "regular";
                            bed = index;
                          });
                        }),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: bed == "one bed"? Container(): Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 250),
                            child: const Text(
                              "beds type: ",
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                )
            ),
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
                    "some information about room*",
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
                    "room price*",
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
                  "insert photos",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 250,right: 20),
              child: ElevatedButton(
                onPressed: ()async{

                  if(roomNumber.text == "" || highClass == null || information.text == "" || price.text == ""){
                    DangerAlertBox(
                        context: context,
                        title: "Wrong",
                        messageText: "miss data, please insert all data that contains *"
                    );
                  }
                  else{
                      bool check = false;
                      for(int i=0;i<Rooms.length;i++){
                        if(Rooms[i]['roomnum'] == roomNumber.text)check = true;
                      }
                      if(check == true){
                        DangerAlertBox(
                            context: context,
                            title: "Wrong",
                            messageText: "this room is already found"
                        );
                      }
                      else{
                        String sweet = "no";
                        String ifseparated = "no";
                        if(separated == "separated"){ifseparated = "yes";}
                        if(roomType == "sweet"){sweet = "yes";}
                        Map map = {
                          "bed":bed,
                          "ifseparated":ifseparated,
                          "infor":information.text,
                          "price":price.text,
                          "reserved":"no",
                          "roomnum":roomNumber.text,
                          "sweet":sweet,
                          "type":highClass,
                          "hotel":{
                            "name":selectAccount[0]['name']
                          }
                        };
                        Rooms.add(map);
                        await setRoom(map);
                        print(images);
                        for(int i=0;i<images.length;i++){
                          await setRoomImage(images[i], selectAccount[0]['name'], roomNumber.text);
                        }
                        images.clear();
                        Navigator.of(context).pop();
                        SuccessAlertBox(
                          context: context,
                          title: "Success",
                          messageText: "room is added"

                        );

                      }

                    }
                  },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),

                ),
                child: const Text(
                  "add room",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

