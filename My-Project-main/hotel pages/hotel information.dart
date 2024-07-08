import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:image_picker/image_picker.dart';

import '../notification/notification_service.dart';

class HotelInformationPage extends StatefulWidget {
  const HotelInformationPage({super.key});

  @override
  State<HotelInformationPage> createState() => _HotelInformationPageState();
}

class _HotelInformationPageState extends State<HotelInformationPage> {
  List<String> listCountries = [], listCities = [];
  String selectCountry = "chose country*",selectCity = "chose city*";
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController information = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  List images = [];
  final imagePicker = ImagePicker();
  uploadPhotoFromGallery()async{
    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    images.add(pickedImage!.path);
}
  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    LocationMap.clear();
    listCities.clear();
    listCountries.clear();
    listCountries.add("chose country*");
    listCities.add("chose city*");
    for(int i=0;i<Countries.length;i++){
      listCountries.add(Countries[i]['name']);
    }
    for(int i=0;i<Cities.length;i++){
      listCities.add(Cities[i]['name']);
    }
    listCountries.add("others");
    listCities.add("others");
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "hotel information",
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
              padding: const EdgeInsets.only(left: 50,right: 40),
              child: DropdownButton<String>(

                focusColor: Colors.blue,
                value: selectCountry,
                onChanged: (newValue) {
                  setState(() {
                    selectCountry = newValue!;
                  });
                },
                items: listCountries.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10,),
            selectCountry == "others"? Container(
              padding: const EdgeInsets.only(right: 20,left: 10),
              child: TextFormField(
                controller: country,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.location_city),
                  label: Text(
                    "if not found enter country her*",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ):Container(),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 50,right: 40),
              child: DropdownButton<String>(
                focusColor: Colors.blue,
                value: selectCity,
                onChanged: (newValue) {
                  setState(() {
                    selectCity = newValue!;
                  });
                },
                items: listCities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10,),
            selectCity == "others"?Container(
              padding: const EdgeInsets.only(right: 20,left: 10),
              child: TextFormField(
                controller: city,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  ),
                  icon: Icon(Icons.location_city),
                  label: Text(
                    "if not found enter city her*",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ): Container(),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 40,top: 20,bottom: 20),
              child: const Text(
                "enter hotel location: ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 100,right: 100),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("setLocation");
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                child: const Text(
                    "set location*",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17

                  ),
                ),
              ),
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
                    "some information about hotel*",
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
              padding: const EdgeInsets.only(left: 260,right: 30),
              child: ElevatedButton(
                onPressed: () async{
                  if(selectCountry.isNotEmpty && selectCountry != "chose country*" && selectCountry != "others"){
                    country.text = selectCountry;
                  }
                  if(selectCity.isNotEmpty && selectCity != "chose city*" && selectCity != "others"){
                    city.text = selectCity;
                  }
                  if(country.text == "" || city.text == "" || LocationMap['lat'] == ""
                  || LocationMap['lng'] == "" || information.text==""){
                    DangerAlertBox(
                        context:context,
                        title: "Wrong",
                        messageText: "miss in input data, please insert all data that contains *"
                    );
                  }
                  else{
                  String? str = "";
                  str = await getCountry(country.text);
                  if(str!.length == 0){
                    print("new country");
                    Map map = {
                      'name':country.text,
                      'rate':"0",
                    };
                    await setCountry(map);
                    Countries.add(map);
                  }
                  str = "[]";
                  str = await getCity(country.text,city.text);
                   if(str == "" || str!.isEmpty || str == null){
                     print("new city");
                     Map map = {
                       'name':city.text,
                       'rate':"0",
                       'country':{
                         'name':country.text,
                       }
                     };
                     String? str1;
                     str1 = await getCountry(country.text);
                     if(str1!.isEmpty || str1 == null || str1 == ""){str1 = "[]";}
                     List list = [];
                     list.addAll(jsonDecode(str1!));
                     if(list[0]['numrate'] == 0.0){
                       await updateCountryNumberRate(country.text, 1.0);
                       int i=0;
                       while(i < Countries.length && Countries[i]['name'] != country.text){i++;}
                       if(i != Countries.length){Countries[i]['numrate'] = 1.0;}
                     }
                     else{
                       double num = list[0]['numrate'] + 1;
                       await updateCountryNumberRate(country.text, num);
                       int i=0;
                       while(i < Countries.length && Countries[i]['name'] != country.text){i++;}
                       if(i != Countries.length){Countries[i]['numrate'] = num;}
                     }
                     await setCity(map);
                     Cities.add(map);
                   }
                   str = "";
                   str = await getHotels();
                   if(str! == "[]" || str == null || str == ""){
                     Map map = {
                       'name':hotelAccount['fname'],
                       "information":information.text,
                       'lat':LocationMap['lng'],
                       "lon":LocationMap['lat'],
                       "city":{
                         'name':city.text,
                       }
                     };
                     String? str1;
                     str1 = await getCity(country.text,city.text);
                     if(str1!.isEmpty || str1 == null || str1 == ""){str1 = "[]";}
                     List list = [];
                     list.addAll(jsonDecode(str1!));
                     if(list[0]['numrate'] == 0.0){
                       await updateCityNumberRate(city.text,country.text, 1.0);
                       int i=0;
                       while(i < Cities.length && (Cities[i]['name'] != city.text || Cities[i]["country"]['name'] != country.text)){i++;}
                       if(i != Cities.length){Cities[i]['numrate'] = 1.0;}
                     }
                     else{
                       double num = list[0]['numrate'] + 1;
                       await updateCityNumberRate(city.text,country.text, num);
                       int i=0;
                       while(i < Cities.length && (Cities[i]['name'] != city.text || Cities[i]["country"]['name'] != country.text)){i++;}
                       if(i != Cities.length){Cities[i]['numrate'] = num;}

                     }
                     await setHotel(map);
                     Hotels.add(map);
                     for(int i=0;i<images.length;i++){
                       await setHotelImage(images[i], hotelAccount['fname']);
                     }
                     images.clear();
                   }
                   else{
                     str = "";
                     str = await getHotel(hotelAccount['fname']);
                     if(str!.isEmpty){
                       Map map = {
                         'name':hotelAccount['fname'],
                         "information":information.text,
                         'lat':latitude.text,
                         "lon":longitude.text,
                         "city":{
                           'name':city.text,
                         }
                       };
                       String?str1;
                       str1 = await getCity(country.text,city.text);
                       if(str1!.isEmpty || str1 == null || str1 == ""){str1 = "[]";}
                       List list = [];
                       list.addAll(jsonDecode(str1!));
                       if(list[0]['numrate'] == 0.0){
                         await updateCityNumberRate(city.text,country.text, 1.0);
                         int i=0;
                         while(i < Cities.length && (Cities[i]['name'] != city.text || Cities[i]["country"]['name'] != country.text)){i++;}
                         if(i != Cities.length){Cities[i]['numrate'] = 1.0;}
                       }
                       else{
                         double num = list[0]['numrate'] + 1;
                         await updateCityNumberRate(city.text,country.text, num);
                         int i=0;
                         while(i < Cities.length && (Cities[i]['name'] != city.text || Cities[i]["country"]['name'] != country.text)){i++;}
                         if(i != Cities.length){Cities[i]['numrate'] = num;}

                       }
                        await setHotel(map);
                        Hotels.add(map);
                        for(int i=0;i<images.length;i++){
                          await setHotelImage(images[i], hotelAccount['fname']);
                        }
                        images.clear();
                     }

                   }
                   Navigator.of(context).pushReplacementNamed("roomInformation");



                  }

                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),

                ),
                child: const Row(
                  children: [
                    Text(
                      "next",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    Icon(
                        Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
