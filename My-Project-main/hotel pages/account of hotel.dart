import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';

import '../notification/notification_service.dart';

class HotelAccountPage extends StatefulWidget {
  const HotelAccountPage({Key? key}) : super(key: key);

  @override
  State<HotelAccountPage> createState() => _HotelAccountPageState();
}

class _HotelAccountPageState extends State<HotelAccountPage> {

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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
            "${selectAccount[0]['name']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushReplacementNamed("requestPage");
          },
          icon: const Icon(Icons.arrow_back),
        ),

      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 200,
              width: 20,
              color: Colors.grey,
              child: InkWell(
                onTap: (){
                  print("naeem");
                },
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20),
             child: ListTile(
                title: Text(
                  "Hotel: ${selectAccount[0]['name']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text(
                  "Country: ${hotelPosition['country']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text(
                  "City: ${hotelPosition['city']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text(
                  "Email: ${selectAccount[0]['email']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text(
                  "Password: ${selectAccount[0]['password']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text(
                  "Phone Number: ${selectAccount[0]['phone']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Divider(thickness: 3,color: Colors.black,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 180),
              child: ListTile(
                title: ElevatedButton(
                  onPressed: (){
                    //Navigator.of(context).pushNamed('changeHotelInformation');
                    InfoAlertBox(
                        context: context,
                        title: "Future work",
                        infoMessage: "this option is ready soon"
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)
                  ),
                  child: const Text(
                    "change",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
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
