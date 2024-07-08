// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:hotel1/lists.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel1/person%20pages/booking.dart';

import '../api.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late final _ratingController;

  double _userRating = 0.0;
  bool _isVertical = false;

  IconData? _selectedIcon;
  @override
  void initState() {
    _ratingController = TextEditingController(text: '0.0');
    super.initState();
  }
  double getSmaleNumber(double number){
    number = number*100;
    int INT = number.toInt();
    double sub = number - INT;
    if(sub >= 0.5){
      INT++;
      number = INT.toDouble();
      number/=100;
    }
    else{
      number = INT.toDouble();
      number/=100;
    }
    return number;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rating your experience",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30,),
          const Center(
            child: Text(
              "rate from 0 to 5 stars:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          const SizedBox(height: 8,),
          const Center(
            child: Text(
              "0-1: Bad",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          const SizedBox(height: 8,),
          const Center(
            child: Text(
              "1-2: Acceptable",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          const SizedBox(height: 8,),
          const Center(
            child: Text(
              "2-3: Good",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          const SizedBox(height: 8,),
          const Center(
            child: Text(
              "3-4: Very good",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          const SizedBox(height: 8,),
          const Center(
            child: Text(
              "4-5: Excellent",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          const SizedBox(height: 30,),
          // const SizedBox(height:250 ,),
          Center(
            child: RatingBarIndicator(
              rating: _userRating,
              itemBuilder: (context, index) => Icon(
                _selectedIcon ?? Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 50.0,
              unratedColor: Colors.amber.withAlpha(50),
              direction: _isVertical ? Axis.vertical : Axis.horizontal,
            ),
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _ratingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter rating',
                labelText: 'Enter rating',
              ),
              onChanged: (text){
                setState(() {
                  double rating;
                  if(text.isEmpty){rating = 0.0;}
                  else{
                    rating = double.parse(text);
                    if(rating > 5.0){rating = 5.0;}
                    else if(rating < 0.0){rating = 0.0;}
                  }
                  _userRating = rating;
                });

              },
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: ElevatedButton(
                onPressed: () async{
                  double rating = double.parse(_ratingController.text);
                  if(rating > 5.0){rating = 5.0;}
                  else if(rating < 0.0){rating = 0.0;}
                  double rate = 0,numberRate = 0,totalRate = 0;
                  String str = await getHotels();
                  if(str == "" || str.isEmpty){str = "[]";}
                  List list = [];
                  list.addAll(jsonDecode(str));
                  int index = 0;
                  for(int i=0;i<list.length;i++){
                    if(list[i]['city']['country']['name'] == book['country_name']){
                      if(list[i]['city']['name'] == book['city_name']){
                        if(list[i]['name'] == book['hotel_name']){index = i;}
                      }
                    }
                  }
                  numberRate = list[index]['numrate'];
                  numberRate++;
                  totalRate = list[index]['totrate'];
                  totalRate += rating;
                  rate = totalRate / numberRate;
                  getSmaleNumber(rate);
                  await updateHotelRate(book['hotel_name'], rate);
                  await updateHotelNumberRate(book['hotel_name'], numberRate);
                  await updateHotelTotalRate(book['hotel_name'], totalRate);
                  //---------------
                  numberRate = 0; totalRate = 0;
                  str = "";
                  str = await getHotels();
                  if(str == "" || str.isEmpty){str = "[]";}
                  list.clear();
                  list = [];
                  list.addAll(jsonDecode(str));
                  int i=0;
                  while(i < list.length){
                    if(list[i]['city']['country']['name'] != book['country_name']){list.removeAt(i);}
                    else if(list[i]['city']['name'] != book['city_name']){list.removeAt(i);}
                    else{i++;}
                  }
                  for(i = 0;i<list.length;i++){
                    if(list[i]['name'] != book['hotel_name']){totalRate += list[i]['rate'];}
                  }
                  totalRate += rate;
                  rate = 0;
                  numberRate = list.length.toDouble();
                  rate = totalRate / numberRate;
                  getSmaleNumber(rate);
                  await updateCityTotalRate(book['city_name'], book['country_name'], totalRate);
                  await updateCityRate(book['city_name'], book['country_name'], rate);
                  //----------
                  totalRate = 0; numberRate = 0;
                  str = "";
                  str = await getCities();
                  if(str == "" || str.isEmpty){str = "[]";}
                  list.clear();
                  list = [];
                  list.addAll(jsonDecode(str));
                  i = 0;
                  while(i < list.length){
                    if(list[i]['country']['name'] != book['country_name']){list.removeAt(i);}
                    else{i++;}
                  }
                  for(i = 0;i < list.length;i++){
                    if(list[i]['name'] != book['city_name']){totalRate += list[i]['rate'];}
                  }
                  totalRate += rate;
                  numberRate = list.length.toDouble();
                  rate = 0;
                  rate = totalRate/numberRate;
                  getSmaleNumber(rate);
                  await updateCountryRate(book['country_name'], rate);
                  await updateCountryTotalRate(book["country_name"], totalRate);
                  //-------------
                  i = 0;
                  index = -1;
                  while(i < Booking.length){
                    if(Booking[i]['id'] == int.parse(book['id'])){
                      index = i;
                      // await deleteBookingById("${Booking[i]['id']}");
                    }
                    await deleteBookingById("${Booking[i]['id']}");
                    if(personBooking.isNotEmpty){
                      Booking.removeAt(i);
                    }
                    if(Booking.isNotEmpty){
                      Booking.removeAt(i);
                    }
                    i++;
                  }
                  Navigator.of(context).pop();
                  InfoAlertBox(
                      context: context,
                      title: "Delete Booking",
                      infoMessage: "Booking delete is complet"
                  );
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                child: const Text(
                  "save rate and remove booking",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                      
                  ),
                )
            ),
          )
        ],
      ),

    );
  }
}
