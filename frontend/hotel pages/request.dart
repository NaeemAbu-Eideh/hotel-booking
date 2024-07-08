

// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hotel1/date_range.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/hotel%20pages/send%20messages.dart';
import 'package:hotel1/notification/notification_service.dart';
import 'dart:convert';
import 'package:hotel1/lists.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}
String name = "", password = "";
bool refresh = false;
class _RequestPageState extends State<RequestPage> {
  setHotelRequest(){
    hotelRequests.clear();
    for(int i=0;i<Requests.length;i++){
      if(Requests[i]['hotel']['name'] == selectAccount[0]['name']){
        hotelRequests.add(Requests[i]);
      }
    }
  }
  Timer? timer;
  Future autoRefreshNotifications()async{
    timer = Timer.periodic(Duration(seconds: 7), (_) async{
      String? str = await getNotifications();
      if(str == null || str == "" || str!.isEmpty){str = "[]";}
      List list = [];
      list.addAll(jsonDecode(str));
      int i=0;
      while(i < list.length){
        if(list[i]['send_to']['email'] != selectAccount[0]['email']){list.removeAt(i);}
        else{
          i++;
        }
      }
      for(int i=0;i<list.length;i++){
        NotificationService.showNotification(
          id: list[i]['id'],
          title: list[i]['title'],
          body: list[i]['body'],
        );
        await deleteNotification(list[i]['send_to']['email'], list[i]['send_from']['email'], list[i]['title'], list[i]['body'], list[i]['type']);
      }
    });
  }
  Future autoRefreshAcceptRequests()async{
    Timer timer2 = Timer.periodic(const Duration(seconds: 15), (timer) async{
      String str = await getAcceptRequests();
      if(str == "" || str.isEmpty){str = "[]";}
      List list = [];
      list.addAll(jsonDecode(str));
      //----
      str = await getBookings();
      if(str == "" || str.isEmpty){str = "[]";}
      List Book = [];
      Book.addAll(jsonDecode(str));
      //----
      str = await getFinishBookingRequests();
      if(str == "" || str.isEmpty){str = "[]";}
      List Finish = [];
      Finish.addAll(jsonDecode(str));
      //----
      str = await getRooms();
      if(str == "" || str.isEmpty){str = "[]";}
      List Room = [];
      Room.addAll(jsonDecode(str));
      //----
      int i= 0 ;
      while(i < list.length){
        if(list[i]['hotel']['name']!= selectAccount[0]['name']){list.removeAt(i);}
        else{i++;}
      }
      i = 0;
      while(i < Room.length){
        if(Room[i]['hotel']['name'] != selectAccount[0]['name']){Room.removeAt(i);}
        else{i++;}
      }
      //=====
      i = 0;
      while(i < list.length){
        DateTime time = DateTime.parse(list[i]['end_date']);
        DateTime timeNow = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
        if(timeNow.isAtSameMomentAs(time)){
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
          Duration duration = now.difference(DateTime.parse(list[i]['start_date']));
          int day = duration.inDays;
          int Room_index = -1;
          for(int j=0;j<Room.length;j++){
              if(Room[j]['roomnum'] == list[i]['roomnum']){
                Room_index = i;
            }
          }

          Map finishNotification = {
            "title":"Expiry of the booking period",
            "body":"hotel has terminated your reservation of room ${list[i]['roomnum']}, total price: ${day * Room[Room_index]['price']}",
            "type":"regular",
            "send_from":{
              "email":selectAccount[0]['email']
            },
            "send_to":{
              "email":list[i]['person']['email']
            },
            "date":date,
            "houre":"${DateTime.now().hour}:${DateTime.now().minute}",
            "time":dayName
          };
          await setNotification(finishNotification);
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
          await setMessage(finishMessage);
          int Book_index = -1;
          for(int j=0;j<Book.length;j++){
            if(Book[j]['hotel']['name'] == list[i]['hotel']['name']){
              if(Book[j]['roomnum'] == list[i]['roomnum']){
                if(Book[j]['person']['email'] == list[i]['person']['email']){
                  if(Book[j]['start_date'] == list[i]['start_date']){
                    if(Book[j]['end_date'] == list[i]['end_date']){
                      Book_index = j;
                    }
                  }
                }
              }
            }
          }
          int Finish_index = -1;
          for(int j=0;j<Finish.length;j++){
            if(Finish[j]['hotel']['name'] == list[i]['hotel']['name']){
              if(Book[j]['roomnum'] == list[i]['roomnum']){
                if(Book[j]['person']['email'] == list[i]['person']['email']){
                  if(Book[j]['start_date'] == list[i]['start_date']){
                    if(Book[j]['end_date'] == list[i]['end_date']){
                      Finish_index = j;
                    }
                  }
                }
              }
            }
          }
          if(Book_index != -1){
            await updateBookingAcceptedById("${Book[Book_index]['id']}", "finish");
            Book.removeAt(Book_index);
          }
          if(Finish_index != -1){
            await deleteFinishBookingRequestsById("${Finish[Finish_index]['id']}");
            Finish.removeAt(Finish_index);
          }
          await deleteAcceptRequestById("${list[i]['id']}");
          list.removeAt(i);
        }
        else{i++;}
      }
      // hotelAcceptRequests.clear();
      // hotelAcceptRequests.addAll(list);
    });
  }
  requestNode(Map node){
    String dayName = "";
    int id = 1;
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
                      "${node['hotel']['name']}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  subtitle:Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10
                        ),
                        child: Text(
                          "room: ${node['roomnum']}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(width: 80,),
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          "city: ${node['hotel']['city']['name']}",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
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
                          onPressed: () async{
                            switch(DateTime.now().weekday){
                              case DateTime.monday:{dayName = "Monday";}break;
                              case DateTime.tuesday:{dayName = "Tuesday";}break;
                              case DateTime.wednesday:{dayName = "Wednesday";}break;
                              case DateTime.thursday:{dayName = "Thursday";}break;
                              case DateTime.friday:{dayName = "Friday";}break;
                              case DateTime.saturday:{dayName = "Saturday";}break;
                              case DateTime.sunday: {dayName = "Sunday";}break;
                            }
                            String? str = "";
                            str = await getRequests();
                            if(str == null || str == "" || str!.length == 0 || str == "[]" || str!.isEmpty){
                              // ignore: use_build_context_synchronously
                              DangerAlertBox(
                                  context: context,
                                  title: "Wrong",
                                  messageText: "this request isn't found"
                              );
                            }
                            else {
                              List list = [];
                              list.clear();
                              list.addAll(jsonDecode(str));
                              int i = 0;
                              while (i < list.length) {
                                if (list[i]['hotel']['name'] != selectAccount[0]['name']) {list.removeAt(i);}
                                else if(list[i]['roomnum'] != node['roomnum']){list.removeAt(i);}
                                else {i++;}
                              }
                              i = 0;
                              while (i < list.length && list[i]['id'] != node['id']) {i++;}
                              if (i == list.length) {
                                // ignore: use_build_context_synchronously
                                DangerAlertBox(
                                    context: context,
                                    title: "Wrong",
                                    messageText: "this request isn't found"
                                );
                              }
                              else {
                                id = Requests.length + 1;
                                Map map = {
                                  "id": id,
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
                                String date = "${DateTime.now().year}-";
                                if (DateTime.now().month < 10) {date += "0${DateTime.now().month}-";}
                                else {date += "${DateTime.now().month}-";}
                                if (DateTime.now().day < 10) {date += "0${DateTime.now().day}";}
                                else {date += "${DateTime.now().day}";}
                                Map acceptNotification = {
                                  "title": "Accept request",
                                  "body": "The registration request for the room ${node['roomnum']} has been approved in date (${node['start_date']} - ${node['end_date']})",
                                  "type": "regular",
                                  "send_from": {
                                    "email": selectAccount[0]['email']
                                  },
                                  "send_to": {
                                    "email": node['person']['email']
                                  },
                                  "date": date,
                                  "houre": "${DateTime
                                      .now()
                                      .hour}:${DateTime
                                      .now()
                                      .minute}",
                                  "time": dayName
                                };
                                Map acceptMessage = {
                                  "title": acceptNotification['title'],
                                  "body": acceptNotification['body'],
                                  "send_to": {
                                    "email": acceptNotification['send_to']['email']
                                  },
                                  "send_from": {
                                    "email": acceptNotification['send_from']['email']
                                  },
                                  "date": acceptNotification['date'],
                                  "houre": acceptNotification['houre'],
                                  "time": acceptNotification['time'],
                                  "type": "send",
                                };
                                await setMessage(acceptMessage);
                                acceptMessage.clear();
                                acceptMessage = {
                                  "title": acceptNotification['title'],
                                  "body": acceptNotification['body'],
                                  "send_to": {
                                    "email": acceptNotification['send_to']['email']
                                  },
                                  "send_from": {
                                    "email": acceptNotification['send_from']['email']
                                  },
                                  "date": acceptNotification['date'],
                                  "houre": acceptNotification['houre'],
                                  "time": acceptNotification['time'],
                                  "type": "receive",
                                };
                                await setMessage(acceptMessage);
                                await setAcceptRequests(map);
                                String b = await getBookings();
                                if (b == "" || b.isEmpty) {
                                  b = "[]";
                                }
                                List B = [];
                                B.addAll(jsonDecode(b));
                                int i = 0;
                                while (i < B.length) {
                                  if(B[i]['roomnum'] != node['roomnum']){B.removeAt(i);}
                                  else if(B[i]['start_date'] != node['start_date']){B.removeAt(i);}
                                  else if(B[i]['end_date'] != node['end_date']){B.removeAt(i);}
                                  else{i++;}
                                }
                                await updateBookingAcceptedById("${B[0]['id']}", "accept");
                                await setNotification(acceptNotification);
                                i = 0;
                                while(i < list.length && list[i]['id'] != node['id']){i++;}
                                list.removeAt(i);
                                await deleteRequestById("${node['id']}");
                                //----------
                                b = "";
                                b = await getBookings();
                                if (b == ""|| b.isEmpty) {
                                  b = "[]";
                                }
                                B.clear();
                                B.addAll(jsonDecode(b));
                                i = 0;
                                while(i < B.length){
                                  if(B[i]["hotel"]['name'] != node['hotel']['name']){B.removeAt(i);}
                                  else if(B[i]['roomnum'] != node['roomnum']){B.removeAt(i);}
                                  else if(B[i]['person']['email'] == node['person']['email']){
                                    if(B[i]['start_date'] == node['start_date'] && B[i]['end_date'] == node['end_date']){B.removeAt(i);}
                                    else{i++;}
                                  }
                                  else{i++;}
                                }
                                int conflict = 0;
                                List<DateRange> dateRange = [];
                                DateTime start = DateTime.parse(node['start_date']);
                                DateTime end = DateTime.parse(node['end_date']);
                                List<DateTime> thisDate = [start,end];
                                i = 0;
                                while(i < B.length){
                                  start = DateTime.parse(B[i]['start_date']);
                                  end = DateTime.parse(B[i]['end_date']);
                                  List<DateTime> date = [start,end];
                                  dateRange = [
                                    DateRange(thisDate[0], thisDate[1]),
                                    DateRange(date[0], date[1])
                                  ];
                                  conflict = countConflictingDateRanges(dateRange);

                                  if(conflict == 0){
                                    B.removeAt(i);
                                  }
                                  else{i++;}
                                }
                                print(B.length);
                                i = 0;
                                while(i < B.length){
                                  await updateBookingAcceptedById("${B[i]['id']}", "reject");
                                  Map rejectNotification = {
                                    "title":"Reject request",
                                    "body":"sorry, room number ${node['roomnum']} is conflict with another person in date (${B[i]['start_date']} to ${B[i]['end_date']}), if you need chose other date",
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
                                  await setNotification(rejectNotification);
                                  Map message = {
                                    "title": rejectNotification['title'],
                                    "body": rejectNotification['body'],
                                    "send_to": {
                                      "email": rejectNotification['send_to']['email']
                                    },
                                    "send_from": {
                                      "email": rejectNotification['send_from']['email']
                                    },
                                    "date": rejectNotification['date'],
                                    "houre": rejectNotification['houre'],
                                    "time": rejectNotification['time'],
                                    "type": "receive",
                                  };
                                  await setMessage(message);
                                  message.clear();
                                  message = {
                                    "title": rejectNotification['title'],
                                    "body": rejectNotification['body'],
                                    "send_to": {
                                      "email": rejectNotification['send_to']['email']
                                    },
                                    "send_from": {
                                      "email": rejectNotification['send_from']['email']
                                    },
                                    "date": rejectNotification['date'],
                                    "houre": rejectNotification['houre'],
                                    "time": rejectNotification['time'],
                                    "type": "send",
                                  };
                                  await setMessage(message);
                                  i++;
                                }
                                //------
                                str = await getRequests();
                                if(str == "" || str!.isEmpty){
                                  str = "[]";
                                }
                                list.clear();
                                list.addAll(jsonDecode(str));
                                i = 0;
                                while(i < list.length){
                                  if(list[i]["hotel"]['name'] != node['hotel']['name']){list.removeAt(i);}
                                  else if(list[i]['roomnum'] != node['roomnum']){list.removeAt(i);}
                                  else if(list[i]['person']['email'] == node['person']['email']){
                                    if(list[i]['start_date'] == node['start_date'] && list[i]['end_date'] == node['end_date']){list.removeAt(i);}
                                    else{i++;}
                                  }
                                  else{i++;}
                                }
                                i = 0;
                                while(i < list.length){
                                  start = DateTime.parse(list[i]['start_date']);
                                  end = DateTime.parse(list[i]['end_date']);
                                  List<DateTime> date = [start,end];
                                  dateRange = [
                                    DateRange(thisDate[0], thisDate[1]),
                                    DateRange(date[0], date[1])
                                  ];
                                  conflict = countConflictingDateRanges(dateRange);

                                  if(conflict == 0){
                                    list.removeAt(i);
                                  }
                                  else{i++;}
                                }
                                i = 0;
                                while(i < list.length){
                                  await deleteRequestById("${list[i]['id']}");
                                  i++;
                                }
                                setState(() {
                                  i = 0;
                                  while(i < hotelRequests.length && hotelRequests[i]['id'] != node['id']){i++;}
                                  hotelRequests.removeAt(i);
                                  Requests.removeAt(i);
                                });
                                //------
                                InfoAlertBox(
                                    context: context,
                                    title: "Accept request",
                                    infoMessage: "this request is accepted"
                                );
                              }
                            }
                            //--------



                          },
                          style: const ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white),
                              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)
                          ),
                          child: const Text(
                            "accept",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ),
                        const SizedBox(width: 40,),
                        ElevatedButton(
                          onPressed: ()async{
                            switch(DateTime.now().weekday){
                              case DateTime.monday:{dayName = "Monday";}break;
                              case DateTime.tuesday:{dayName = "Tuesday";}break;
                              case DateTime.wednesday:{dayName = "Wednesday";}break;
                              case DateTime.thursday:{dayName = "Thursday";}break;
                              case DateTime.friday:{dayName = "Friday";}break;
                              case DateTime.saturday:{dayName = "Saturday";}break;
                              case DateTime.sunday: {dayName = "Sunday";}break;
                            }
                            String? str = await getRequests();
                            if(str == null || str!.length == 0 || str!.isEmpty || str == ""){
                              // ignore: use_build_context_synchronously
                              DangerAlertBox(
                                  context: context,
                                  title: "Wrong",
                                  messageText: "this request isn't found"
                              );
                            }
                            else{
                              List list = [];
                              list.clear();
                              list.addAll(jsonDecode(str!));
                              int i=0;
                              while(i < list.length){
                                if(list[i]['hotel']['name'] != selectAccount[0]['name']){
                                  list.removeAt(i);
                                }
                                else{i++;}
                              }
                              i = 0;
                              while(i < list.length && list[i]['id'] != node['id']){i++;}
                              if(i == list.length){
                                // ignore: use_build_context_synchronously
                                DangerAlertBox(
                                    context: context,
                                    title: "Wrong",
                                    messageText: "this request isn't found"
                                );
                              }
                              else{
                                String date = "${DateTime.now().year}-";
                                if(DateTime.now().month < 10){date+= "0${DateTime.now().month}-";}
                                else{date+= "${DateTime.now().month}-";}
                                if(DateTime.now().day < 10){date+= "0${DateTime.now().day}";}
                                else{date+= "${DateTime.now().day}";}
                                Map rejectNotification = {
                                  "title":"Reject request",
                                  "body":"The booking request for room ${node['roomnum']} has been rejected in date(${node['start_date']} to ${node['end_date']})",
                                  "type":"regular",
                                  "send_from":{
                                    "email":selectAccount[0]['email']
                                  },
                                  "send_to":{
                                    "email":node['person']['email']
                                  },
                                  "date":date,
                                  "time":dayName,
                                  "houre":"${DateTime.now().hour}:${DateTime.now().minute}",
                                  'type':"send"

                                };
                                Map rejectMessage = {
                                  "title":rejectNotification['title'],
                                  "body":rejectNotification['body'],
                                  "send_from":{
                                    "email":rejectNotification['send_from']['email']
                                  },
                                  "send_to":{
                                    "email":rejectNotification['send_to']['email']
                                  },
                                  "date":rejectNotification['date'],
                                  "time":rejectNotification['time'],
                                  "houre":rejectNotification['houre']

                                };
                                Messages.add(rejectMessage);
                                await setMessage(rejectMessage);
                                rejectMessage.clear();
                                rejectMessage = {
                                  "title":"Reject request",
                                  "body":"The booking request for room ${node['roomnum']} has been rejected",
                                  "type":"regular",
                                  "send_from":{
                                    "email":selectAccount[0]['email']
                                  },
                                  "send_to":{
                                    "email":node['person']['email']
                                  },
                                  "date":date,
                                  "time":dayName,
                                  "houre":"${DateTime.now().hour}:${DateTime.now().minute}",
                                  'type':"receive"

                                };
                                Messages.add(rejectMessage);
                                await setMessage(rejectMessage);
                                str = await getBookings();
                                if(str == "" || str!.isEmpty){str = "[]";}
                                list.clear();
                                list.addAll(jsonDecode(str));
                                i = 0;
                                while(i < list.length){
                                  if(list[i]['hotel']['name'] != node['hotel']['name']){
                                    list.removeAt(i);}
                                  else if(list[i]['roomnum'] != node['roomnum']){
                                    list.removeAt(i);}
                                  else if(list[i]['person']['email'] != node['person']['email']){
                                    list.removeAt(i);}
                                  else if(list[i]['start_date'] != node['start_date'] || list[i]['end_date'] != node['end_date']){
                                    print("naeem");
                                    list.removeAt(i);}
                                  else{i++;}
                                }
                                await updateBookingAcceptedById("${list[0]['id']}","reject");
                                await deleteRequestById("${node['id']}");
                                await setNotification(rejectNotification);
                                // ignore: use_build_context_synchronously
                                setState(() {
                                  i = 0;
                                  while(i < hotelRequests.length && hotelRequests[i]['id'] != node['id']){i++;}
                                  hotelRequests.removeAt(i);
                                  Requests.removeAt(i);
                                });
                                InfoAlertBox(
                                    context: context,
                                    title: "Request",
                                    infoMessage: "this request is reject"
                                );

                              }
                            }
                          },

                          style: const ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white),
                              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)
                          ),
                          child: const Text(
                            "reject",
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
  void initState() {
    setHotelRequest();
    //---
    autoRefreshNotifications();
    autoRefreshAcceptRequests();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.request_page),
              label: "request"),
          BottomNavigationBarItem(
              icon: Icon(Icons.room),
              label: "reserved rooms"),
           BottomNavigationBarItem(
               icon: Icon(Icons.account_circle),
               label: "account"
           ),
        ],
        onTap: (index){
          setState(() {
            ind = index;
            if(index == 0){
              Navigator.of(context).pushReplacementNamed("requestPage");
            }
            else if(index == 1){
              Navigator.of(context).pushReplacementNamed("acceptRequests");
            }
            else if(index == 2){
              if(selectAccount.isEmpty){
                showModalBottomSheet(context: context, builder: (context){
                  return Container(
                    height: 300,
                    child: ListView(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 100,
                        ),
                        const Text(
                          "you are not registered in an account, please enter your account or create a new account",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            SizedBox(width: 60,),
                            Container(
                              child:
                              ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed("login");
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                                  ),
                                  child: const Text(
                                    "sign in",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  )),

                            ),
                            SizedBox(width: 50,),
                            Container(
                              child:
                              ElevatedButton(
                                  onPressed: (){},
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                                  ),
                                  child: const Text(
                                    "sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  )),

                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
              }
              else{
                // ignore: use_build_context_synchronously
                showModalBottomSheet(context: context, builder: (context){
                  return Container(
                    height: 300,
                    child: ListView(
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.account_circle,
                            size: 100,
                          ),),
                        Text(
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          "account: ${selectAccount[0]['name']}",
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              selectAccount.clear();
                              Navigator.of(context).pushNamed("main");
                            },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                foregroundColor: MaterialStatePropertyAll(Colors.white)
                            ),
                            child: const Text(
                              "logout",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }
            }
          });
        },
        currentIndex: ind,
      ),
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
      onSelected: (value) async{
    switch(value){
    case "option1":{ Navigator.of(context).pushNamed("changeHotelInformation");} break;
    case "option2":{ Navigator.of(context).pushNamed("hotelRoomsPage");} break;
    case "option3":{ Navigator.of(context).pushNamed("addRoom");} break;
    case "option4":{ Navigator.of(context).pushNamed("finishBookingRequestsPage");} break;
    case "option5":{ Navigator.of(context).pushNamed("hotelSendMessages");} break;
    case "option6":{ Navigator.of(context).pushNamed("hotelReceiveMessages");} break;
    case "option7":{
    String str = await getHotels();
    if(str == "" || str.isEmpty){str = "[]";}
    List list = [];
    list.addAll(jsonDecode(str));
    int i=0;
    while(i < list.length && list[i]['name'] != selectAccount[0]['name']){i++;}
    hotelPosition['country'] = list[i]['city']['country']['name'];
    hotelPosition['city'] = list[i]['city']['name'];
    Navigator.of(context).pushNamed("hotelAccount");
    } break;
    }
    },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'option1',
            child: Text('change hotel information'),
          ),
          const  PopupMenuItem<String>(
            value: 'option2',
            child: Text('change room information'),
          ),
          const  PopupMenuItem<String>(
            value: 'option3',
            child: Text('add room'),
          ),
          const  PopupMenuItem<String>(
            value: 'option4',
            child: Text('finish booking requests'),
          ),
          const  PopupMenuItem<String>(
            value: 'option5',
            child: Text('sent messages'),
          ),
          const  PopupMenuItem<String>(
            value: 'option6',
            child: Text('received messages'),
          ),
          const  PopupMenuItem<String>(
            value: 'option7',
            child: Text('account'),
          ),
        ];
      },
      child: const Icon(
        Icons.menu,
        size: 30,
        color: Colors.black,
      ), // Icon or any other trigger
    ),
          IconButton(
            onPressed: ()async{
               setState(() {
                 refresh = true;
               });
               await refreshData();
               setState(() {
                 hotelRequests.clear();
                 for(int i=0;i<Requests.length;i++){
                   if(Requests[i]['hotel']['name'] == selectAccount[0]['name']){
                     hotelRequests.add(Requests[i]);
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
            "Requests",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),

        ),
        leading: IconButton(
          onPressed: (){
            ConfirmAlertBox(
              context: context,
              title: "go to home page",
              infoMessage: "the account will be logged out if you go to the main page, are you sure you want to go out?",
              onPressedYes: (){
                print("naeem");
                selectAccount.clear();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            );

          },
          icon: Icon(Icons.arrow_back),
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
                child: requestNode(hotelRequests[i]));
          },
          itemCount: hotelRequests.length,
        ),
      ),
    );
  }
}
