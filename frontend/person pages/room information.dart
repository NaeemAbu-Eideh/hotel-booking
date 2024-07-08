import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel1/api.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../notification/notification_service.dart';
class InformationOfRoomPage extends StatefulWidget {
  const InformationOfRoomPage({super.key});

  @override
  State<InformationOfRoomPage> createState() => _InformationOfRoomPageState();
}

class _InformationOfRoomPageState extends State<InformationOfRoomPage> {
  List listRoom = [], roomImages = [];
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    int index = 0;
    for(int i=0;i<Rooms.length;i++){
      if(Rooms[i]['hotel']['name'] == info['hotel']){
        if(Rooms[i]['roomnum'] == info['room']){index = i;}
      }
    }
    listRoom.clear();
    listRoom.add(Rooms[index]);
    //-----------
    for(int i=0;i<RoomsImages.length;i++){
      if(RoomsImages[i]['hotel'] == info['hotel']){
        if(RoomsImages[i]['room'] == info['room']){
          roomImages.add(RoomsImages[i]['image']);
        }
      }
    }
    //-----
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("information",style: TextStyle(
           fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/page2.jpeg"),
                fit: BoxFit.fill
            )
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            roomImages.isEmpty? Container(): ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                roomImages.length == 1? Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Image.memory(base64Decode(roomImages[0].toString()), fit: BoxFit.fill,),
                ): Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: CarouselSlider(
                    items: roomImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Image.memory(
                              base64Decode(image),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    }).toList(),
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: roomImages.map((image) {
                      int index = roomImages.indexOf(image);
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index ? Colors.blue : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
            //----------
            ListTile(
                title:Text(
                  "room: ${info['room']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "hotel: ${info['hotel']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "city: ${info['city']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "high class: ${listRoom[0]['type']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "room type: ${listRoom[0]['sweet'] == "no"? "regular": "sweet"}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "number of beds: ${listRoom[0]['bed']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "if separated: ${listRoom[0]['ifseparated']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              title:Text(
                "information: ${listRoom[0]['infor']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),

          ],
        ),
      )
    );
  }
}
