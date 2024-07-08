// ignore_for_file: use_build_context_synchronously
import 'package:hotel1/date_range.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});
  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  String dayName = "";
  String? startDate,endDate;
  bool check = false;
  DateTime? data1, data2;
  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    //startTimer();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "reservation",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              child: const Row(
                children: [
                  Text(
                    "Booked dates",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  )
                ],
              ),
              onTap: () async{
                String str = await getAcceptRequests();
                if(str == "" || str.isEmpty || str == null){
                  str = "[]";
                }
                List list = [];
                list.addAll(jsonDecode(str));
                int i=0;
                while(i < list.length){
                  if(list[i]['hotel']['name'] == info['hotel'] && list[i]['roomnum'] == info['room']){i++;}
                  else{list.removeAt(i);}
                }
                showModalBottomSheet(context: context, builder: (context){
                  return Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context,i){
                        return Container(
                          padding: const EdgeInsets.only(
                            top: 50,
                            left: 40,
                            bottom: 20
                          ),
                          child: Text(
                            "${list[i]['start_date']} to ${list[i]['end_date']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        );
                      },
                      itemCount: list.length,
                    ),
                  );
                });
              },
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/page.jpg"),
                fit: BoxFit.fill
            )
        ),
        padding:const EdgeInsets.only(top: 100),
        child: ListView(
          children: [
            Center(
                child: Text(
                    "room number: ${info['room']}",
                   style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 25
                   ),
                )
            ),
            const SizedBox(),
            Container(
              padding: const EdgeInsets.only(left: 100,top: 30),
              child: const Text(
                "enter a date of start",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 50,right: 30),
              child: ElevatedButton(
                onPressed: ()async{
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if(picked != null && picked != data1){
                    data1 = picked;
                  }
                  setState(() {
                    int month = 0,day = 0;
                    if(data1!.month < 10){
                      if(data1!.day < 10){
                        startDate = "${data1?.year}-0${data1?.month}-0${data1?.day}";
                      }
                      else{
                        startDate = "${data1?.year}-0${data1?.month}-${data1?.day}";
                      }
                    }
                    else{
                      if(data1!.day < 10){
                        startDate = "${data1?.year}-${data1?.month}-0${data1?.day}";
                      }
                      else{
                        startDate = "${data1?.year}-${data1?.month}-${data1?.day}";
                      }

                    }
                  });

                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                child: const Text(
                  "select date",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 100,top: 10),
              child:  Text(
                " date: ${startDate}",
                style:const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 100,top: 50),
              child: const Text(
                "enter a date of end",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 50,right: 30),
              child: ElevatedButton(
                onPressed: ()async{
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if(picked != null && picked != data2){
                    data2 = picked;
                  }
                  setState(() {
                    int month = 0,day = 0;
                    if(data2!.month < 10){
                      if(data2!.day < 10){
                        endDate = "${data2?.year}-0${data2?.month}-0${data2?.day}";
                      }
                      else{
                        endDate = "${data2?.year}-0${data2?.month}-${data2?.day}";
                      }
                    }
                    else{
                      if(data2!.day < 10){
                        endDate = "${data2?.year}-${data2?.month}-0${data2?.day}";
                      }
                      else{endDate = "${data2?.year}-${data2?.month}-${data2?.day}";}

                    }
                  });

                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                child: const Text(
                  "select date",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 100,top: 10),
              child:  Text(
                " date: ${endDate}",
                style:const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const SizedBox(width: 120,),
                ElevatedButton(
                  onPressed: ()async {
                    if (endDate == null || startDate == null ||
                        endDate == "null-null-null" ||
                        startDate == "null-null-null") {
                      DangerAlertBox(
                          context: context,
                          title: "Wrong",
                          messageText: "please enter start-date and end-date"
                      );
                    }

                    else {
                      int conflict = 0;
                      int conflictCount = 0;
                      String str = await getAcceptRequests();
                      if (str == "" || str.isEmpty || str == null) {
                        str = "[]";
                      }
                      List list = [];
                      list.addAll(jsonDecode(str));
                      int i = 0;
                      while (i < list.length) {
                        if (list[i]['hotel']['name'] == info['hotel'] &&
                            list[i]['roomnum'] == info['room']) {
                          i++;
                        }
                        else {
                          list.removeAt(i);
                        }
                      }
                      //----
                      List<DateRange> dateRange = [];
                      DateTime start = DateTime.parse(startDate!);
                      DateTime end = DateTime.parse(endDate!);
                      List<DateTime> newDate = [start,end];
                      //----
                      i = 0;
                      while (i < list.length) {
                        start = DateTime.parse(list[i]['start_date']);
                        end = DateTime.parse(list[i]['end_date']);
                        List<DateTime> date = [start,end];
                        //-----
                        dateRange = [
                          DateRange(newDate[0], newDate[1]),
                          DateRange(date[0], date[1])
                        ];
                        conflict = countConflictingDateRanges(dateRange);
                        if(conflict == 1){conflictCount++;}
                        i++;
                      }
                      if (conflictCount != 0) {
                        DangerAlertBox(
                            context: context,
                            title: "Wrong",
                            messageText: "this date is conflict with other date, chose other date"
                        );
                      }
                      else{
                        DateTime nowDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                        if(data1!.isBefore(nowDate)){
                          DangerAlertBox(
                            context: context,
                            title: "Wrong",
                            messageText: "start date is before the current date, please enter date that is the same or after current date"
                          );
                        }
                        else{
                          int year1 = data1!.year,year2 = data2!.year;
                          int month1 = data1!.month,month2 = data2!.month;
                          int day1 = data1!.day,day2 = data2!.day;
                          int year = year2-year1;
                          int month = month2-month1;
                          int day = 0;
                          Duration duration = data2!.difference(data1!);
                          day = duration.inDays;
                          int? totalPrice;
                          totalPrice = (day * info['roomPrice']) as int?;
                          if(day >= 0){
                            if(month>= 0){
                              if(year>= 0){
                                String r = await getRooms();
                                int i = 0;
                                List R = [];
                                R.addAll(jsonDecode(r));
                                while(i < R.length && R[i]['roomnum'] != info['room']){i++;}

                                if(R[i]['reserved'] == "no"){
                                  String? str = await getAccounts();
                                  if(str == "" || str!.isEmpty || str == null){str = "[]";}
                                  List list = [];
                                  list.addAll(jsonDecode(str!));
                                  int k = 0;
                                  while(k < list.length && list[k]['fname'] != info['hotel']){k++;}
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
                                  print("date: $date");
                                  Map request = {
                                    "end_date": endDate,
                                    "person_name": selectAccount[0]['name'],
                                    "roomnum": info['room'],
                                    "start_date": startDate,
                                    "hotel": {
                                      "name": info['hotel']
                                    },
                                    "person": {
                                      "email": selectAccount[0]['email']
                                    }
                                  };
                                  Map booking = {
                                    "end_date": endDate,
                                    "person_name": selectAccount[0]['name'],
                                    "roomnum": info['room'],
                                    "start_date": startDate,
                                    "hotel": {
                                      "name": info['hotel']
                                    },
                                    "person": {
                                      "email": selectAccount[0]['email']
                                    },
                                    "total_price":totalPrice,
                                    "accepted":"check"
                                  };
                                  Map notification = {
                                    "title":"Request a reservation",
                                    "body":"We have received a request to book a room ${info['room']}"
                                        " from a client",
                                    "type":"regular",
                                    "send_from":{
                                      "email":selectAccount[0]['email']
                                    },
                                    "send_to":{
                                      "email":list[k]['email']
                                    },
                                    "date":date,
                                    "houre":"${DateTime.now().hour}:${DateTime.now().minute}",
                                    "time":dayName

                                  };
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
                                    "type":"send"
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
                                    "type":"receive"
                                  };
                                  await setMessage(message);
                                  await setBooking(booking);
                                  await setRequest(request);
                                  await setNotification(notification);
                                  Navigator.of(context).pop();
                                  // ignore: use_build_context_synchronously
                                  SuccessAlertBox(
                                      context: context,
                                      title: "Success",
                                      messageText: "booking is complete successfully"
                                  );
                                }
                                else{
                                  DangerAlertBox(
                                      context: context,
                                      title: "Wrong",
                                      messageText: "this room is already reserved"

                                  );
                                }

                              }
                              else{
                                DangerAlertBox(
                                    context: context,
                                    title: "Wrong",
                                    messageText: "end date must greater than start date"
                                );
                              }
                            }
                            else{
                              DangerAlertBox(
                                  context:  context,
                                  title: "Wrong",
                                  messageText: "end date must greater than start date"
                              );
                            }
                          }
                          else{
                            DangerAlertBox(
                                context: context,
                                title: "Wrong",
                                messageText: "end date must greater than start date"
                            );
                          }
                        }
                      }
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Text(
                    "book",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(width: 40,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Text(
                    "cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
