// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/lists.dart';


class AcceptRequestPage extends StatefulWidget {
  const AcceptRequestPage({super.key});

  @override
  State<AcceptRequestPage> createState() => _AcceptRequestPageState();
}
class _AcceptRequestPageState extends State<AcceptRequestPage> {
  TextEditingController roomNumber = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  int ind = 1;
  bool refresh = false;
  bool find = false;
  List Find = [];
  Timer? timer;
  acceptRequestsNode(Map node){
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
                            String str = await getAcceptRequests();
                            if(str == "" || str.isEmpty){str = "[]";}
                            List accept = [];
                            accept.addAll(jsonDecode(str));
                            if(accept==[] || accept.isEmpty || accept.length == 0){
                              DangerAlertBox(
                                  context: context,
                                  title: "Wrong",
                                  messageText: "this booking isn't found"
                              );
                            }
                            else{
                              int i = 0;
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
                                "body":"hotel has terminated your reservation of room ${node['roomnum']}, total price: ${day * list[0]['price']}",
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
                              str = await getFinishBookingRequests();
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
                              if(list.isNotEmpty){
                                await deleteFinishBookingRequestsById("${list[0]['id']}");
                              }
                              await setMessage(finishMessage);
                              await deleteAcceptRequestById("${node['id']}");
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
                                while(i < hotelAcceptRequests.length && hotelAcceptRequests[i]['id'] != node['id']){
                                  i++;
                                }
                                hotelAcceptRequests.removeAt(i);
                                AcceptRequests.removeAt(i);
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
                            "finish reservation",
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
    hotelAcceptRequests.clear();
    for(int i=0;i<AcceptRequests.length;i++){
      if(AcceptRequests[i]['hotel']['name'] == selectAccount[0]['name']){
        hotelAcceptRequests.add(AcceptRequests[i]);
      }
    }
    //-------
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
              print(selectAccount);
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
                showModalBottomSheet(context: context, builder: (context){
                  return SizedBox(
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
                hotelAcceptRequests.clear();
                for(int i=0;i<AcceptRequests.length;i++){
                  if(AcceptRequests[i]['hotel']['name'] == selectAccount[0]['name']){
                    hotelAcceptRequests.add(AcceptRequests[i]);
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
          "Accepted requests",
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
      ):
      Container(
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
                child: find == true? acceptRequestsNode(Find[i]): acceptRequestsNode(hotelAcceptRequests[i]));
          },
          itemCount: find == true? Find.length: hotelAcceptRequests.length,
        ),
      ),
      floatingActionButton: find == false?  FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (_)=> Container(
          padding: const EdgeInsets.only(bottom: 200,top: 100),
          child: AlertDialog(
            title: const Center(child: Text("Find"),),
            content: Column(
              children: [
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
                      if(list[i]['roomnum'].toString() == roomNumber.text){
                        if(list[i]['start_date'].toString() == startDate.text){
                          if(list[i]['end_date'].toString() == endDate.text){
                            Find.add(list[i]);
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

