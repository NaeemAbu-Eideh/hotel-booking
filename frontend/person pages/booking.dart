// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:hotel1/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
class BookingPage extends StatefulWidget {
  const BookingPage({super.key});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController roomNumber = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController hotelName = TextEditingController();
  bool refresh = false;
  bool find = false;
  List Find = [];
  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    personBooking.clear();
    for (int i = 0; i < Booking.length; i++) {
      if (Booking[i]['person']['email'] == selectAccount[0]['email']) {
        personBooking.add(Booking[i]);
      }
    }
    //------
    startTimer();
    super.initState();
  }
  reservationNode(Map node){
    return  Container(
      padding: const EdgeInsets.only(bottom: 20,top: 20),
      color: Colors.black,
      child: Card(
        color: Colors.grey,
        child: Column(
          children: [
            ListTile(
              title: Column(
                children: [
                  Text(
                    "hotel: ${node['hotel']['name']}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "room: ${node['roomnum']}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                "country: ${node['hotel']['city']['country']['name']} , city: ${node['hotel']['city']['name']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),

            ),
            Container(
              padding: EdgeInsets.only(left: 100),
              child: Text(
                "start date: ${node['start_date']}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 100),
              child: Text(
                "end date: ${node['end_date']}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 100),
              child: Text(
                "total price: ${node['total_price']}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
                padding: EdgeInsets.only(left: 100),
                child: node['accepted'] == "check"? const Text(
                  "checked",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ):
                Container(
                    child: node['accepted'] == "accept"? Container(
                      child: const Text(
                        "accept",
                        style: TextStyle(
                            color: Colors.lightGreenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ):
                    Container(
                        child: node['accepted'] == "finish"? Container(
                          child: const Text(
                            "finish",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                            : Container(
                          child: const Text(
                            "reject",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    )
                )
            ),
            const SizedBox(height: 10,),
            Container(
              child: node['accepted'] == "finish"? Container(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        int j=0;
                        while(j < Booking.length && Booking[j]['id'] != node['id']){j++;}
                        if(j == Booking.length){
                          DangerAlertBox(
                              context:context,
                              title: "Wrong",
                              messageText: "this booking is not found"
                          );
                        }
                        else{
                          j=0;
                          while(j < personBooking.length && personBooking[j]['id'] != node['id']){j++;}
                          if(j == personBooking.length){
                            DangerAlertBox(
                                context:context,
                                title: "Wrong",
                                messageText: "this booking is not found"
                            );
                          }
                          else{
                            book['country_name'] = node['hotel']['city']['country']['name'];
                            book['city_name'] = node['hotel']['city']['name'];
                            book['hotel_name'] = node['hotel']['name'];
                            book['room_number'] = node['roomnum'];
                            book['id'] = "${node['id']}";
                            Navigator.of(context).pushNamed("rating");
                          }

                        }

                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                          foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ),
                      child:const Text(
                        "if you want, rate your experience",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),
                      ),
                    ),
                  ],
                ),
              ):Container(),
            ),
            ElevatedButton(
              onPressed: () async {
                int j = 0;
                String b = await getBookings();
                if (b == "" || b.isEmpty) {
                  b = "[]";
                }
                List B = [];
                B.addAll(jsonDecode(b));
                while (j < B.length && B[j]['id'] != node['id']) {
                  j++;
                }
                if (j == B.length) {
                  DangerAlertBox(
                      context: context,
                      title: "Wrong",
                      messageText: "this booking is not found"
                  );
                }
                else {
                  String dayName = "";
                  String? str = "";
                  str = await getAccounts();
                  if (str == null || str!.isEmpty) {
                    str = "[]";
                  }
                  List list = [];
                  list.addAll(jsonDecode(str));
                  String email = "";
                  int i = 0;
                  while (i < list.length && list[i]['fname'] != node['hotel']['name']) {i++;}
                  email = list[i]['email'];
                  str = "";
                  str = await getBookings();
                  if (str == null || str == "[]" || str!.isEmpty || str == "") {
                    // ignore: use_build_context_synchronously
                    DangerAlertBox(
                        context: context,
                        title: "Wrong",
                        messageText: "this booking isn't found"
                    );
                  }
                  else {
                    List list = [];
                    list.addAll(jsonDecode(str!));
                    if (list == [] || list.isEmpty) {
                      // ignore: use_build_context_synchronously
                      DangerAlertBox(
                          context: context,
                          title: "Wrong",
                          messageText: "this booking isn't found"
                      );
                    }
                    else {
                      for (int i = 0; i < list.length;) {
                        if (list[i]['person']['email'] != selectAccount[0]['email']) {list.removeAt(i);}
                        else {i++;}
                      }
                      int i = 0;
                      while (i < list.length && list[i]['id'] != node['id']) {i++;}
                      if (i == list.length) {
                        // ignore: use_build_context_synchronously
                        DangerAlertBox(
                            context: context,
                            title: "Wrong",
                            messageText: "this booking isn't found"
                        );
                      }
                      else {
                        switch (DateTime.now().weekday) {
                          case DateTime.monday:{dayName = "Monday";}break;
                          case DateTime.tuesday:{dayName = "Tuesday";}break;
                          case DateTime.wednesday:{dayName = "Wednesday";}break;
                          case DateTime.thursday:{dayName = "Thursday";}break;
                          case DateTime.friday:{dayName = "Friday";}break;
                          case DateTime.saturday:{dayName = "Saturday";}break;
                          case DateTime.sunday:{dayName = "Sunday";}break;
                        }
                        if (node['accepted'] == "check") {
                          int i = 0;
                          String date = "${DateTime.now().year}-";
                          if (DateTime.now().month < 10) {date += "0${DateTime.now().month}-";}
                          else {date += "${DateTime.now().month}-";}
                          if (DateTime.now().day < 10) {date += "0${DateTime.now().day}";}
                          else {date += "${DateTime.now().day}";}
                          Map notification = {
                            "title": "cancel request",
                            "body": "you don't have to accept my request, i'm cancel this request",
                            "type": "regular",
                            "send_from": {
                              "email": selectAccount[0]['email']
                            },
                            "send_to": {
                              "email": email
                            },
                            "date": date,
                            "houre": "${DateTime.now().hour}:${DateTime.now().minute}",
                            "time": dayName
                          };
                          Map message = {
                            "title": notification['title'],
                            "body": notification['body'],
                            "send_to": {
                              "email": notification['send_to']['email']
                            },
                            "send_from": {
                              "email": notification['send_from']['email']
                            },
                            "date": notification['date'],
                            "houre": notification['houre'],
                            "time": notification['time'],
                            "type": "send"
                          };
                          await setMessage(message);
                          message.clear();
                          message = {
                            "title": notification['title'],
                            "body": notification['body'],
                            "send_to": {
                              "email": notification['send_to']['email']
                            },
                            "send_from": {
                              "email": notification['send_from']['email']
                            },
                            "date": notification['date'],
                            "houre": notification['houre'],
                            "time": notification['time'],
                            "type": "receive"
                          };
                          str = await getRequests();
                          if (str!.isEmpty || str == "") {
                            str == "[]";
                          }
                          List R = [];
                          R.addAll(jsonDecode(str));
                          i = 0;
                          while(i < R.length){
                            if(R[i]['hotel']['name']!= node['hotel']['name']){R.removeAt(i);}
                            else if (R[i]['person']['email'] != node['person']['email']){R.removeAt(i);}
                            else if(R[i]['roomnum'] != node['roomnum']){R.removeAt(i);}
                            else if(R[i]['start_date'] != node['start_date']){R.removeAt(i);}
                            else if(R[i]['end_date'] != node['end_date']){R.removeAt(i);}
                            else{i++;}
                          }
                          await setMessage(message);
                          await deleteRequestById("${R[0]['id']}");
                          print(node['id']);
                          await deleteBookingById("${node['id']}");
                          await setNotification(notification);
                        }
                        else if (node['accepted'] == "accept") {
                          String date = "${DateTime.now().year}-";
                          if (DateTime.now().month < 10) {date += "0${DateTime.now().month}-";}
                          else {date += "${DateTime.now().month}-";}
                          if (DateTime.now().day < 10) {date += "0${DateTime.now().day}";}
                          else {date += "${DateTime.now().day}";}
                          Map map = {
                            "end_date": node['end_date'],
                            "person_name": node["person_name"],
                            "roomnum": node["roomnum"],
                            "start_date": node['start_date'],
                            "total_price": "",
                            "hotel": {
                              "name": node['hotel']['name']
                            },
                            "person": {
                              "email": node['person']['email']
                            }
                          };
                          await setFinishBookingRequests(map);
                          Map notification = {
                            "title": "finish request",
                            "body": "i need cancel the reservation for room ${node['roomnum']}",
                            "type": "regular",
                            "send_from": {
                              "email": selectAccount[0]['email']
                            },
                            "send_to": {
                              "email": email
                            },
                            "date": date,
                            "houre": "${DateTime.now().hour}:${DateTime.now().minute}",
                            "time": dayName
                          };
                          Map message = {
                            "title": notification['title'],
                            "body": notification['body'],
                            "send_to": {
                              "email": notification['send_to']['email']
                            },
                            "send_from": {
                              "email": notification['send_from']['email']
                            },
                            "date": notification['date'],
                            "houre": notification['houre'],
                            "time": notification['time'],
                            "type": "send"
                          };
                          await setMessage(message);
                          message.clear();
                          message = {
                            "title": notification['title'],
                            "body": notification['body'],
                            "send_to": {
                              "email": notification['send_to']['email']
                            },
                            "send_from": {
                              "email": notification['send_from']['email']
                            },
                            "date": notification['date'],
                            "houre": notification['houre'],
                            "time": notification['time'],
                            "type": "receive"
                          };
                          await setMessage(message);
                          str = await getAcceptRequests();
                          if (str!.isEmpty || str == "") {
                            str == "[]";
                          }
                          List R = [];
                          R.addAll(jsonDecode(str));
                          i = 0;
                          while(i < R.length){
                            if(R[i]['hotel']['name']!= node['hotel']['name']){R.removeAt(i);}
                            else if (R[i]['person']['email'] != node['person']['email']){R.removeAt(i);}
                            else if(R[i]['roomnum'] != node['roomnum']){R.removeAt(i);}
                            else if(R[i]['start_date'] != node['start_date']){R.removeAt(i);}
                            else if(R[i]['end_date'] != node['end_date']){R.removeAt(i);}
                            else{i++;}
                          }
                          await setNotification(notification);
                        }
                        else {
                          await deleteBookingById("${node['id']}");
                        }
                        if(node['accepted'] != "accept"){
                          setState(() {
                            int index = 0;
                            while(index < personBooking.length && personBooking[index]['id'] != node['id']){index++;}
                            if(personBooking.isNotEmpty){
                              personBooking.removeAt(index);
                            }
                            if(Booking.isNotEmpty){
                              Booking.removeAt(index);
                            }

                          });
                        }
                      }
                    }
                  }
                }
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
              ),
              child:const Text(
                "remove booking",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "your bookings",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                refresh = true;
              });
              await refreshData();
              setState(() {
                personBooking.clear();
                for (int i = 0; i < Booking.length; i++) {
                  if (Booking[i]['person']['email'] == selectAccount[0]['email']) {
                    personBooking.add(Booking[i]);
                  }
                }
                refresh = false;
              });
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: refresh == true ? const Center(
        child: CircularProgressIndicator(),
      ) :
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/page2.jpeg"),
                  fit: BoxFit.fill
              )
          ),
          padding: EdgeInsets.only(left: 30, right: 30, top: 40),
          child: ListView.builder(
            itemBuilder: (context, i) {
               return Dismissible(
                    onDismissed: (con) async{
                    },
                   key: Key("${i}"),
                    child: find == false? reservationNode(personBooking[i]) : reservationNode(Find[i])); //ListReservation(notes: personBooking[i],));
            },
            itemCount: find == false? personBooking.length: Find.length,)
      ),
      floatingActionButton: find == false?  FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (_)=> Container(
          padding: const EdgeInsets.only(bottom: 130,top: 100),
          child: AlertDialog(
            title: const Center(child: Text("Find"),),
            content: Column(
              children: [
                Row(
                  children: [
                    const Text("hotel name"),
                    const SizedBox(width: 8,),
                    Container(
                      width: 115,
                      padding: const EdgeInsets.only(left: 15),
                      child: TextField(
                        controller: hotelName,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2)
                            )
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("room number"),
                    const SizedBox(width: 8,),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: roomNumber,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2)
                            )
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("start date"),
                    const SizedBox(width: 8,),
                    Container(
                      width: 150,
                      padding: const EdgeInsets.only(left: 25),
                      child: TextField(
                        controller: startDate,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2)
                            )
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("end date"),
                    const SizedBox(width: 8,),
                    Container(
                      width: 157,
                      padding: const EdgeInsets.only(left: 30),
                      child: TextField(
                        controller: endDate,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2)
                            )
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: ()async{
                  String str = await getAcceptRequests();
                  if(str == "" || str.isEmpty){str = "[]";}
                  List list = [];
                  list.addAll(jsonDecode(str));
                  setState(() {
                    Find.clear();
                    for(int i=0;i<list.length;i++){
                      if(list[i]['hotel']['name'] == hotelName.text){
                        if(list[i]['roomnum'].toString() == roomNumber.text){
                          if(list[i]['start_date'].toString() == startDate.text){
                            if(list[i]['end_date'].toString() == endDate.text){
                              Find.add(list[i]);
                            }
                          }
                        }
                      }
                    }
                    find = true;
                    Navigator.of(context).pop();
                  });
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                child: const Text(
                  "yes",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                child: const Text(
                  "no",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ));
      } , child: Icon(Icons.search),):
      FloatingActionButton(onPressed: (){
        setState(() {
          find = false;
        });
      } , child: Icon(Icons.search_off),),
    );
  }
}
