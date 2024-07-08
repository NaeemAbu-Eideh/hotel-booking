// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/lists.dart';

class FinishBookingRequestsPage extends StatefulWidget {
  const FinishBookingRequestsPage({super.key});

  @override
  State<FinishBookingRequestsPage> createState() => _FinishBookingRequestsPageState();
}



class _FinishBookingRequestsPageState extends State<FinishBookingRequestsPage> {
  int ind = 1;
  bool refresh = false;

  Timer? timer;
  Future startTimer()async{
  }

  @override
  void initState() {
    finishBookingRequests.clear();
    for(int i=0;i<FinishBookingRequests.length;i++){
      if(FinishBookingRequests[i]['hotel']['name'] == selectAccount[0]['name']){
        finishBookingRequests.add(FinishBookingRequests[i]);
      }
    }
    //-------
    startTimer();
    super.initState();
  }
  finishBookingRequestNode(Map node){
    return  Container(
      padding: const EdgeInsets.only(top:20,left: 10,right: 10,bottom: 30),
      child: Card(
          color: Colors.grey,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3,
                  color: Colors.black
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(
                        left: 100
                    ),
                    child: Text(
                      "room: ${node['roomnum']}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Divider(height: 10,endIndent:5,indent: 5,thickness: 3,color: Colors.black,),
                const SizedBox(height: 10,),
                ListTile(
                  title: Text(
                    "${node['person_name']}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    "${node['person']['email']}",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  title: Text(
                    "start: ${node['start_date']}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    "end: ${node['end_date']}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                    title: Row(
                      children: [
                        const SizedBox(width: 10,),
                        ElevatedButton(
                          onPressed: ()async{
                            String str = await getFinishBookingRequests();
                            if(str == "" || str.isEmpty){str = "[]";}
                            List finish = [];
                            finish.addAll(jsonDecode(str));
                            if(finish.isEmpty || finish.length == 0){
                              DangerAlertBox(
                                  context: context,
                                  title: "Wrong",
                                  messageText: "this booking isn't found"
                              );
                            }
                            else{
                              int i=0;
                              String dayName = "";
                              switch(DateTime.now().weekday){
                                case DateTime.monday:{dayName = "Monday";}break;
                                case DateTime.tuesday:{dayName = "Tuesday";}break;
                                case DateTime.wednesday:{dayName = "Wednesday";}break;
                                case DateTime.thursday:{dayName = "Thursday";}break;
                                case DateTime.friday:{dayName = "Friday";}break;
                                case DateTime.saturday:{dayName = "Saturday";}break;
                                case DateTime.sunday: {dayName = "Sunday";}break;
                              }
                              String date = "${DateTime.now().year}-";
                              if(DateTime.now().month < 10){date+= "0${DateTime.now().month}-";}
                              else{date+= "${DateTime.now().month}-";}
                              if(DateTime.now().day < 10){date+= "0${DateTime.now().day}";}
                              else{date+= "${DateTime.now().day}";}
                              //-----
                              String time = "${DateTime.now().year}-";
                              if(DateTime.now().month < 10){time+= "0${DateTime.now().month}-";}
                              else{time+= "${DateTime.now().month}-";}
                              if(DateTime.now().day < 10){time+= "0${DateTime.now().day}";}
                              else{time+= "${DateTime.now().day}";}
                              DateTime now = DateTime.parse(time);
                              //------
                              Duration duration = now.difference(DateTime.parse(node['start_date']));
                              int day = duration.inDays;
                              if(day == 0){day = 1;}
                              String str = await getRooms();
                              if(str == "" || str.isEmpty){str = "[]";}
                              List list = [];
                              list.addAll(jsonDecode(str));
                              int j=0;
                              while(j < list.length){
                                if(list[j]['hotel']['name'] != selectAccount[0]['name']){list.removeAt(j);}
                                else if(list[j]['roomnum'] != node['roomnum']){list.removeAt(j);}
                                else{
                                  j++;
                                }
                              }

                              Map finishNotification = {
                                "title":"Expiry of the booking period",
                                "body":"hotel has accepted to terminated your reservation of room ${node['roomnum']}, total price: ${day * list[0]['price']}",
                                "type":"regular",
                                "send_from":{
                                  "email":selectAccount[0]['email']
                                },
                                "send_to":{
                                  "email":node['person']['email']
                                },
                                "date":date,
                                "houre":"${DateTime.now().hour}:${DateTime.now().minute}",
                                "time":dayName
                              };
                              Map finishMessage = {
                                "title": finishNotification['title'],
                                "body":finishNotification['body'],
                                "send_to":{
                                  "email":finishNotification['send_to']['email']
                                },
                                "send_from":{
                                  "email":finishNotification['send_from']['email']
                                },
                                "date":finishNotification['date'],
                                "houre":finishNotification['houre'],
                                "time":finishNotification['time'],
                                "type": "send"
                              };
                              await setMessage(finishMessage);
                              finishMessage.clear();
                              finishMessage = {
                                "title": finishNotification['title'],
                                "body":finishNotification['body'],
                                "send_to":{
                                  "email":finishNotification['send_to']['email']
                                },
                                "send_from":{
                                  "email":finishNotification['send_from']['email']
                                },
                                "date":finishNotification['date'],
                                "houre":finishNotification['houre'],
                                "time":finishNotification['time'],
                                "type": "receive"
                              };
                              str = await getAcceptRequests();
                              if(str == "" || str!.isEmpty){str == "[]";}
                              list.clear();
                              list.addAll(jsonDecode(str));
                              i=0;
                              while(i < list.length){
                                if(list[i]['hotel']['name'] != node['hotel']['name']){list.removeAt(i);}
                                else if(list[i]['person']['email'] != node['person']['email']){list.removeAt(i);}
                                else if(list[i]['roomnum'] != node["roomnum"]){list.removeAt(i);}
                                else if(list[i]['start_date'] != node['start_date'] || list[i]['end_date'] != node['end_date']){list.removeAt(i);}
                                else{i++;}
                              }
                              await deleteAcceptRequestById("${list[0]['id']}");
                              await setMessage(finishMessage);
                              await deleteFinishBookingRequestsById("${node['id']}");
                              await setNotification(finishNotification);
                              str = await getBookings();
                              if(str == "" || str!.isEmpty){str == "[]";}
                              list.clear();
                              list.addAll(jsonDecode(str));
                              i=0;
                              while(i < list.length){
                                if(list[i]['hotel']['name'] != node['hotel']['name']){list.removeAt(i);}
                                else if(list[i]['person']['email'] != node['person']['email']){list.removeAt(i);}
                                else if(list[i]['roomnum'] != node["roomnum"]){list.removeAt(i);}
                                else if(list[i]['start_date'] != node['start_date'] || list[i]['end_date'] != node['end_date']){list.removeAt(i);}
                                else{i++;}
                              }
                              await updateBookingAcceptedById("${list[0]['id']}" ,"finish");
                              // ignore: use_build_context_synchronously
                              setState(() {
                                i = 0;
                                while(i < finishBookingRequests.length && finishBookingRequests[i]['id'] != node['id']){
                                  i++;
                                }
                                finishBookingRequests.removeAt(i);
                                FinishBookingRequests.removeAt(i);
                              });
                              InfoAlertBox(
                                  context: context,
                                  title: "Accept Request",
                                  infoMessage: "this booking has removed,the room number ${node['roomnum']} is empty now"
                              );
                            }
                          },
                          style: const ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white),
                              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)
                          ),
                          child: const Text(
                            "yes",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: ()async{
                            String str = await getFinishBookingRequests();
                            if(str == "" || str.isEmpty){str = "[]";}
                            List finish = [];
                            finish.addAll(jsonDecode(str));
                            if(finish.isEmpty || finish.length == 0){
                              DangerAlertBox(
                                  context: context,
                                  title: "Wrong",
                                  messageText: "this booking isn't found"
                              );
                            }
                            else{
                              String dayName = "";
                              switch(DateTime.now().weekday){
                                case DateTime.monday:{dayName = "Monday";}break;
                                case DateTime.tuesday:{dayName = "Tuesday";}break;
                                case DateTime.wednesday:{dayName = "Wednesday";}break;
                                case DateTime.thursday:{dayName = "Thursday";}break;
                                case DateTime.friday:{dayName = "Friday";}break;
                                case DateTime.saturday:{dayName = "Saturday";}break;
                                case DateTime.sunday: {dayName = "Sunday";}break;
                              }
                              String date = "${DateTime.now().year}-";
                              if(DateTime.now().month < 10){date+= "0${DateTime.now().month}-";}
                              else{date+= "${DateTime.now().month}-";}
                              if(DateTime.now().day < 10){date+= "0${DateTime.now().day}";}
                              else{date+= "${DateTime.now().day}";}
                              //-----
                              String time = "${DateTime.now().year}-";
                              if(DateTime.now().month < 10){time+= "0${DateTime.now().month}-";}
                              else{time+= "${DateTime.now().month}-";}
                              if(DateTime.now().day < 10){time+= "0${DateTime.now().day}";}
                              else{time+= "${DateTime.now().day}";}
                              DateTime now = DateTime.parse(time);
                              Map notification = {
                                "title":"reject request",
                                "body":"hotel has reject your request terminated your reservation of room ${node['roomnum']}",
                                "type":"regular",
                                "send_from":{
                                  "email":selectAccount[0]['email']
                                },
                                "send_to":{
                                  "email":node['person']['email']
                                },
                                "date":date,
                                "houre":"${DateTime.now().hour}:${DateTime.now().minute}",
                                "time":dayName
                              };
                              await setNotification(notification);
                              Map message = {
                                "title": notification['title'],
                                "body":notification['body'],
                                "send_to":{
                                  "email":notification['send_to']['email']
                                },
                                "send_from":{
                                  "email":notification['send_from']['email']
                                },
                                "date":notification['date'],
                                "houre":notification['houre'],
                                "time":notification['time'],
                                "type": "send"
                              };
                              await setMessage(message);
                              message.clear();
                              message = {
                                "title": notification['title'],
                                "body":notification['body'],
                                "send_to":{
                                  "email":notification['send_to']['email']
                                },
                                "send_from":{
                                  "email":notification['send_from']['email']
                                },
                                "date":notification['date'],
                                "houre":notification['houre'],
                                "time":notification['time'],
                                "type": "receive"
                              };
                              await setMessage(message);
                              await deleteFinishBookingRequestsById("${node['id']}");
                            }
                          },
                          style: const ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white),
                              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)
                          ),
                          child: const Text(
                            "no",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ),
                      ],
                    )
                ),

              ],
            ),
          )
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()async{
              setState(() {
                refresh = true;
              });
              await refreshData();
              setState(() {
                finishBookingRequests.clear();
                for(int i=0;i<AcceptRequests.length;i++){
                  if(AcceptRequests[i]['hotel']['name'] == selectAccount[0]['name']){
                    finishBookingRequests.add(AcceptRequests[i]);
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
        title: const Text(
          "Finish Booking Requests",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),

        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: refresh == true? const Center(
        child: CircularProgressIndicator(),
      ): Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/page2.jpeg"),
              fit: BoxFit.fill
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context,i){
            return Dismissible(
                key: Key("${i}"),
                child: finishBookingRequestNode(finishBookingRequests[i]));
          },
          itemCount: finishBookingRequests.length,
        ),
      ),
    );
  }
}


