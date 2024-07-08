import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel1/api.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../notification/notification_service.dart';

class InformationOfHotelPage extends StatefulWidget {
  const InformationOfHotelPage({Key? key}) : super(key: key);

  @override
  State<InformationOfHotelPage> createState() => _InformationOfHotelPageState();
}

class _InformationOfHotelPageState extends State<InformationOfHotelPage> {
  List listHotel = [], hotelImages = [];
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  Timer? timer;
  Future startTimer()async{}

  @override
  void initState() {
    int i=0;
    int index = 0;
    bool check = false;
    while(i < Hotels.length){
      if(Hotels[i]['name'] == info['hotel']){index = i;check = true;}
      i++;
    }
    listHotel.clear();
    listHotel.add(Hotels[index]);
    //--------
    for(i = 0; i<HotelsImages.length;i++){
      if(HotelsImages[i]['hotel'] == info['hotel']){
        hotelImages.add(HotelsImages[i]['image']);
      }
    }
    //------
    startTimer();
    super.initState();
  }
  int i = 0;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
            "Hotel Information",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/page2.jpeg"),
              fit: BoxFit.fill
          ),
        ),
        child: ListView(
          children: [
            hotelImages.isEmpty?Container():ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: hotelImages.length == 1? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Image.memory(base64Decode(hotelImages[0].toString()), fit: BoxFit.fill,),
                  ): CarouselSlider(
                    items: hotelImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Image.memory(
                              base64Decode(image.toString()),
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
                    children: hotelImages.map((image) {
                      int index = hotelImages.indexOf(image);
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
            //----
            ListTile(
                title: Container(
                  padding: const EdgeInsets.only(top:30,left: 20),
                  child: Text(
                    "Hotel: ${info['hotel']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                )
            ),
            const SizedBox(height: 20,),
            ListTile(
                title: Container(
                  padding: const EdgeInsets.only(top:30,left: 20),
                  child: Text(
                    "Country: ${info['country']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                )
            ),
            const SizedBox(height: 20,),
            ListTile(
                title: Container(
                  padding: const EdgeInsets.only(top:30,left: 20),
                  child: Text(
                    "City: ${info['city']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                )
            ),
            const SizedBox(height: 20,),
            ListTile(
                title: Container(
                  padding: const EdgeInsets.only(top:30,left: 20),
                  child: Text(
                    "Rate: ${info['hotel_rate']}/ 5.0",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                )
            ),
            const SizedBox(height: 20,),
            ListTile(
                title: Container(
                  padding: const EdgeInsets.only(top:30,left: 20),
                  child: Text(
                    "Information: ${listHotel[0]['informartion']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                )
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            i = index;
            if(i == 0){
              Navigator.of(context).pushReplacementNamed("informationOfHotel");
            }
            else if(i == 1){
              int index = 0;
              for(int i=0;i<Hotels.length;i++){
                if(Hotels[i]['name'] == info['hotel']){index = i;}
              }
              LocationMap['lon'] = Hotels[index]['lon'];
              LocationMap['lat'] = Hotels[index]['lat'];
              Navigator.of(context).pushReplacementNamed("map");
            }
          });
        },
        currentIndex: i,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.perm_device_information),label: "information"),
          BottomNavigationBarItem(icon: Icon(Icons.map),label: "map"),
        ],
      ),

    );
  }
}
