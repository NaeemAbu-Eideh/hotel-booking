import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:image_picker/image_picker.dart';

import '../notification/notification_service.dart';

class ChangeHotelInformationPage extends StatefulWidget {
  const ChangeHotelInformationPage({super.key});

  @override
  State<ChangeHotelInformationPage> createState() => _ChangeHotelInformationPageState();
}

class _ChangeHotelInformationPageState extends State<ChangeHotelInformationPage> {
  List<String> listCountries = [], listCities = [];
  String selectCountry = "chose country",selectCity = "chose city";
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
    listCountries.add("chose country");
    listCities.add("chose city");
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
                    "if not found enter country her",
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
                    "if not found enter city her",
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
                "change hotel location: ",
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
                  "set location",
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
                    "some information about hotel",
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
                  InfoAlertBox(
                    context: context,
                    title: "Future work",
                    infoMessage: "this option is ready soon"
                  );
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
