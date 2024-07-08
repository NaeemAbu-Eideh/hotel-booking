import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/lists.dart';
import '../notification/notification_service.dart';



class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool filter = false;
  bool all = true;
  bool refresh = false;

  String? highClass = "regular"
  , roomType = "regular"
  ,bed = "one bed"
  ,separated = "regular";

  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    room.clear();
    for(int i=0;i<Rooms.length;i++){
      if(Rooms[i]['hotel']['name'] == info['hotel']){
        room.add(Rooms[i]);
      }
    }
    //-----
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel Booking',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: (){
              rooms.clear();
              for(int i=0;i<room.length;i++){
                rooms.add("room: ${room[i]['roomnum']}");
              }
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async{
              setState(() {
                refresh = true;
              });
              await refreshData();
              setState(() {
                room.clear();
                for(int i=0;i<Rooms.length;i++){
                  if(Rooms[i]['hotel']['name'] == info['hotel']){
                    room.add(Rooms[i]);
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black.withOpacity(0.8),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              const Divider(),
              IconButton(
                  onPressed: (){
                    if(selectAccount.isEmpty){
                      Navigator.of(context).pushNamed("login");
                    }
                    else{
                      Navigator.of(context).pushNamed("personAccount");
                    }

                  },
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 80,
                  )
              ),
              ListTile(
                title: selectAccount.isEmpty? const  Text(
                  "you have not looged in to this page via an account, click on this icon to login",
                  style: TextStyle(color: Colors.white),
                ):
                Text(
                  "name: ${selectAccount[0]['name']}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Divider(),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.only(left: 15,right: 20),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed("informationOfHotel");
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                      ),
                      Text(
                        "information of hotel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20

                        ),
                      ),
                    ],
                  ),

                ),
              ),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.only(left: 15,right: 80),
                child: ElevatedButton(
                  onPressed: (){
                    rooms.clear();
                    for(int i=0;i<room.length;i++){
                      rooms.add("room: ${room[i]['roomnum']}");
                    }
                    showSearch(context: context, delegate: Search());
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                      ),
                      Text(
                        "find a room",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20

                        ),
                      ),
                    ],
                  ),

                ),
              ),
              const SizedBox(height: 10,),
              selectAccount.isEmpty? Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20,right: 90),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("login");
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.login,
                                  size: 30,
                                ),
                                Text(
                                  "  login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20

                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.only(left: 20,right: 90),
                      child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              showModalBottomSheet(
                                backgroundColor: Colors.black.withOpacity(0.7),
                                context: context,
                                builder: (context){
                                  return Container(
                                    height: 200,
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(top: 50),
                                          child: const Text(
                                            "chose your account type",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            const SizedBox(width: 80,),
                                            ElevatedButton(
                                              onPressed: (){
                                                Navigator.of(context).pushReplacementNamed("person_signup");
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                                foregroundColor: MaterialStatePropertyAll(Colors.white),
                                                textStyle: MaterialStatePropertyAll(
                                                    TextStyle(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                ),
                                              ),
                                              child: const Text("person"),
                                            ),
                                            const SizedBox(width: 40,),
                                            ElevatedButton(
                                              onPressed: (){
                                                Navigator.of(context).pushReplacementNamed("hotel_signup");
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                                foregroundColor: MaterialStatePropertyAll(Colors.white),
                                                textStyle: MaterialStatePropertyAll(
                                                    TextStyle(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                ),
                                              ),
                                              child: const Text("hotel"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.create,
                                  size: 30,
                                ),
                                Text(
                                  "  signup",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20

                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ) :
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15,right: 70),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("yourBooking");
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Container(
                            // margin: const EdgeInsets.only(left: 30),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.create,
                                  size: 30,
                                ),
                                Text(
                                  " your bookings",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20

                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.only(left: 10,right: 70),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("personSendMessages");
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 1),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 30,
                                ),
                                Text(
                                  "sent messages",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20

                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.only(right: 45),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("personReceiveMessages");
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 1),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 30,
                                ),
                                Text(
                                  "received messages",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20

                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.only(left: 20,right: 90),
                      child: ElevatedButton(
                          onPressed: (){
                            selectAccount.clear();
                            while(Navigator.of(context).canPop() == true){
                              Navigator.of(context).pop();
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 30,
                                ),
                                Text(
                                  "  logout",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20

                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body :  refresh == true?  const Center(
    child: CircularProgressIndicator(),
    ) :
      Container(
          padding: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/page2.jpeg"),
                          fit: BoxFit.fill
                      )
                  ),
          child: all == true? ListView(
            children: [
              Container(
                child: filter == false? Container():Container(
                  height: 250,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                "high class: ",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 50,),
                                const Text(
                                  "regular",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Radio(value: "regular", groupValue: highClass, onChanged: (index){
                                  setState(() {
                                    roomType = "regular";
                                    bed = "one bed";
                                    separated = "regular";
                                    highClass = index;
                                  });
                                }),
                                const SizedBox(width: 20,),
                                const Text(
                                  "vip",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Radio(value: "vip", groupValue: highClass, onChanged: (index){
                                  setState(() {
                                    roomType = "regular";
                                    bed = "one bed";
                                    separated = "regular";
                                    highClass = index;
                                  });
                                }),
                                const SizedBox(width: 20,),
                                const Text(
                                  "vvip",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Radio(value: "vvip", groupValue: highClass, onChanged: (index){
                                  setState(() {
                                    roomType = "regular";
                                    bed = "one bed";
                                    separated = "regular";
                                    highClass = index;
                                  });
                                }),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Container(
                                child: highClass == "regular"? Container():Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 250),
                                      child: const Text(
                                        "room type: ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 50,),
                                        const Text(
                                          "sweet",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "sweet", groupValue: roomType, onChanged: (index){
                                          setState(() {
                                            bed = "one bed";
                                            separated = "regular";
                                            roomType = index;
                                          });
                                        }),
                                        const SizedBox(width: 20,),
                                        const Text(
                                          "regular",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "regular", groupValue: roomType, onChanged: (index){
                                          setState(() {
                                            bed = "one bed";
                                            separated = "regular";
                                            roomType = index;
                                          });
                                        }),

                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      padding: const EdgeInsets.only(right: 300),
                                      child: const Text(
                                        "bed: ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 50,),
                                        const Text(
                                          "one bed",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "one bed", groupValue: bed, onChanged: (index){
                                          setState(() {
                                            separated = "regular";
                                            bed = index;
                                          });
                                        }),
                                        const SizedBox(width: 20,),
                                        const Text(
                                          "two beds",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "two beds", groupValue: bed, onChanged: (index){
                                          setState(() {
                                            separated = "regular";
                                            bed = index;
                                          });
                                        }),

                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      child: bed == "one bed"? Container(): Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(right: 250),
                                            child: const Text(
                                              "beds type: ",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(width: 50,),
                                              const Text(
                                                "separated",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Radio(value: "separated", groupValue: separated, onChanged: (index){
                                                setState(() {
                                                  separated = index;
                                                });
                                              }),
                                              const SizedBox(width: 20,),
                                              const Text(
                                                "regular",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Radio(value: "regular", groupValue: separated, onChanged: (index){
                                                setState(() {
                                                  separated = index;
                                                });
                                              }),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                )
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 240,right: 60
                              ),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                                ),
                                onPressed: (){
                                  setState(() {
                                    roomFilter['highClass'] = "";
                                    roomFilter['roomType'] = "";
                                    roomFilter['bed'] = "";
                                    roomFilter['separated'] = "";
                                    if(highClass == "regular"){
                                      roomFilter['highClass'] = highClass;
                                    }
                                    else{
                                      roomFilter['highClass'] = highClass;
                                      roomFilter["roomType"] = roomType;
                                      if(bed == "one bed"){
                                        roomFilter['bed'] = bed;
                                      }
                                      else{
                                        roomFilter['bed'] = bed;
                                        if(separated == "separated"){
                                          roomFilter['separated'] = 'yes';
                                        }
                                        else{
                                          roomFilter['separated'] = 'no';
                                        }
                                      }
                                    }
                                    if(roomFilter['roomType'] == ""){
                                      roomFilter['roomType'] = "regular";
                                    }
                                    if(roomFilter[bed] == ""){
                                      roomFilter["bed"] = "one bed";
                                    }
                                    if(roomFilter['separated'] == ""){
                                      roomFilter['separated'] = "no";
                                    }
                                    //------
                                    filterRooms.clear();
                                    if(roomFilter['highClass'] == "regular"){
                                      for(int i=0;i<room.length;i++){
                                        if(room[i]['type'] == "regular"){
                                          filterRooms.add(room[i]);
                                        }
                                      }
                                    }
                                    else if(roomFilter['highClass'] == "vip"){
                                      for(int i=0;i<room.length;i++){
                                        if(room[i]['type'] == "vip"){
                                          filterRooms.add(room[i]);
                                        }
                                      }
                                    }
                                    else if(roomFilter['highClass'] == "vvip"){
                                      for(int i=0;i<room.length;i++){
                                        if(room[i]['type'] == "vvip"){
                                          filterRooms.add(room[i]);
                                        }
                                      }
                                    }
                                    //-------
                                    if(roomFilter['highClass'] != "regular"){
                                      if(roomFilter['roomType'] == 'sweet'){
                                        for(int i=0;i<filterRooms.length;i++){
                                          if(filterRooms[i]['sweet'] == "no"){
                                            filterRooms.removeAt(i);
                                          }
                                        }
                                      }
                                      else if (roomFilter['roomType'] == "regular"){
                                        for(int i=0;i<filterRooms.length;i++){
                                          if(filterRooms[i]['sweet'] == "yes"){
                                            filterRooms.removeAt(i);
                                          }
                                        }
                                      }
                                      //----
                                      if(roomFilter['bed'] == "one bed"){
                                         for(int i=0;i<filterRooms.length;i++){
                                           if(filterRooms[i]['bed'] == 'two beds'){
                                             filterRooms.removeAt(i);
                                           }
                                         }
                                      }
                                      else if(roomFilter['bed'] == "two beds"){
                                        for(int i=0;i<filterRooms.length;i++){
                                          if(filterRooms[i]['bed'] == 'one bed'){
                                            filterRooms.removeAt(i);
                                          }
                                        }
                                        //-----
                                        if(roomFilter['separated'] == 'yes'){
                                          for(int i=0;i<filterRooms.length;i++){
                                            if(filterRooms[i]['ifseparated'] == 'no'){
                                              filterRooms.removeAt(i);
                                            }
                                          }
                                        }
                                        else if(roomFilter['separated'] == 'no'){
                                          for(int i=0;i<filterRooms.length;i++){
                                            if(filterRooms[i]['ifseparated'] == 'yes'){
                                              filterRooms.removeAt(i);
                                            }
                                          }
                                        }
                                      }
                                    }

                                    all = false;
                                    filter = false;
                                  });
                                },
                                child:const Text(
                                  "ok",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Divider(thickness: 2,),
                    ],
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "rooms",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,i){
                  return ListRooms(notes: room[i],);
                },
                itemCount: room.length,)
            ],
          ):
          ListView(
            children: [
              Container(
                child: filter == false? Container():Container(
                  height: 250,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                "high class: ",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 50,),
                                const Text(
                                  "regular",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Radio(value: "regular", groupValue: highClass, onChanged: (index){
                                  setState(() {
                                    roomType = "regular";
                                    bed = "one bed";
                                    separated = "regular";
                                    highClass = index;
                                  });
                                }),
                                const SizedBox(width: 20,),
                                const Text(
                                  "vip",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Radio(value: "vip", groupValue: highClass, onChanged: (index){
                                  setState(() {
                                    roomType = "regular";
                                    bed = "one bed";
                                    separated = "regular";
                                    highClass = index;
                                  });
                                }),
                                const SizedBox(width: 20,),
                                const Text(
                                  "vvip",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Radio(value: "vvip", groupValue: highClass, onChanged: (index){
                                  setState(() {
                                    roomType = "regular";
                                    bed = "one bed";
                                    separated = "regular";
                                    highClass = index;
                                  });
                                }),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Container(
                                child: highClass == "regular"? Container():Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 250),
                                      child: const Text(
                                        "room type: ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 50,),
                                        const Text(
                                          "sweet",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "sweet", groupValue: roomType, onChanged: (index){
                                          setState(() {
                                            bed = "one bed";
                                            separated = "regular";
                                            roomType = index;
                                          });
                                        }),
                                        const SizedBox(width: 20,),
                                        const Text(
                                          "regular",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "regular", groupValue: roomType, onChanged: (index){
                                          setState(() {
                                            bed = "one bed";
                                            separated = "regular";
                                            roomType = index;
                                          });
                                        }),

                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      padding: const EdgeInsets.only(right: 300),
                                      child: const Text(
                                        "bed: ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 50,),
                                        const Text(
                                          "one bed",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "one bed", groupValue: bed, onChanged: (index){
                                          setState(() {
                                            separated = "regular";
                                            bed = index;
                                          });
                                        }),
                                        const SizedBox(width: 20,),
                                        const Text(
                                          "two beds",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Radio(value: "two beds", groupValue: bed, onChanged: (index){
                                          setState(() {
                                            separated = "regular";
                                            bed = index;
                                          });
                                        }),

                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      child: bed == "one bed"? Container(): Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(right: 250),
                                            child: const Text(
                                              "beds type: ",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(width: 50,),
                                              const Text(
                                                "separated",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Radio(value: "separated", groupValue: separated, onChanged: (index){
                                                setState(() {
                                                  separated = index;
                                                });
                                              }),
                                              const SizedBox(width: 20,),
                                              const Text(
                                                "regular",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Radio(value: "regular", groupValue: separated, onChanged: (index){
                                                setState(() {
                                                  separated = index;
                                                });
                                              }),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                )
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 240,right: 60
                              ),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                                ),
                                onPressed: (){
                                  setState(() {
                                    if(highClass == "regular"){
                                      roomFilter['highClass'] = highClass;
                                    }
                                    else{
                                      roomFilter['highClass'] = highClass;
                                      roomFilter["roomType"] = roomType;
                                      if(bed == "one bed"){
                                        roomFilter['bed'] = bed;
                                      }
                                      else{
                                        roomFilter['bed'] = bed;
                                        if(separated == "separated"){
                                          roomFilter['separated'] = 'yes';
                                        }
                                        else{
                                          roomFilter['separated'] = 'no';
                                        }
                                      }
                                    }
                                    filter = false;
                                  });
                                },
                                child:const Text(
                                  "ok",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Divider(thickness: 2,),
                    ],
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "rooms",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,i){
                  return ListRooms(notes: filterRooms[i],);
                },
                itemCount: filterRooms.length,)
            ],
          )
      ),
      floatingActionButton: all == true? FloatingActionButton(
        onPressed: (){
          setState(() {
            filter = true;
          });
        },
        child: Icon(Icons.filter_alt),
      ):
      FloatingActionButton(
        onPressed: (){
          setState(() {
            all = true;
          });
        },
        child: Icon(Icons.filter_alt_off),
      ),
    );
  }
}

class ListRooms extends StatelessWidget{

  final notes;
  ListRooms({this.notes});
  @override
  Widget build(BuildContext context){
    return  Container(
      child: InkWell(
        onTap: (){
          info['room'] = notes['roomnum'];
          Navigator.of(context).pushNamed("informationOfRoom");
        },
        child: Card(
          color: Colors.black,
          child: Row(
            children: [
              const SizedBox(width: 30,),
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    Container(
                      child: Text(
                        "${notes["hotel"]['name']}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),

                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: Text(
                        "room: ${notes['roomnum']}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),

                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: Text(
                        "price: ${notes['price']}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),

                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: ElevatedButton(
                        onPressed: (){
                          if(selectAccount.isEmpty){
                            // ignore: use_build_context_synchronously
                            WarningAlertBox(
                              context: context,
                              title: "warning",
                              messageText: "you can't reservation without enter with your account",

                            );
                          }
                          else{
                            // ignore: use_build_context_synchronously
                            info['room'] = notes['roomnum'];
                            info['roomPrice'] = notes['price'];
                            Navigator.of(context).pushNamed("reservation");
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                        ),
                        child: const Text(
                          "reservation",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = "";
        },
        icon: Icon(Icons.arrow_back),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed:(){
        close(context,null);
      } ,
      icon: const Icon(Icons.close),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return InkWell(
      child:  Card(
        color: Colors.black,
        child: Row(
          children: [
            Container(
               height: 240,
              padding: const EdgeInsets.only(left: 60,),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Container(
                    child: Text(
                      "${selectRooms[0]["hotel"]['name']}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),

                  ),
                  const SizedBox(height: 20,),
                  Container(
                    child: Text(
                      "room: ${selectRooms[0]['roomnum']}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),

                  ),
                  const SizedBox(height: 20,),
                  Container(
                    child: Text(
                      "price: ${selectRooms[0]['price']}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),

                  ),
                  SizedBox(height: 20,),
                  selectRooms[0]['reserved'] == "no"? Container():Container(
                    child: ElevatedButton(
                      onPressed: (){
                        if(selectAccount.isEmpty){
                          // ignore: use_build_context_synchronously
                          WarningAlertBox(
                            context: context,
                            title: "warning",
                            messageText: "you can't reservation without enter with your account",

                          );
                        }
                        else{
                          // ignore: use_build_context_synchronously

                          info['room'] = selectRooms[0]['roomnum'];
                          info['roomPrice'] = selectRooms[0]['price'];
                          Navigator.of(context).pushNamed("reservation");
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      child: const Text(
                        "reservation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        info['room'] = selectRooms[0]['roomnum'];
        Navigator.of(context).pushNamed("informationOfRoom");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List filter = rooms.where((element) => element.contains(query)).toList();

    return Container(
      padding: const EdgeInsets.only(left: 30,top: 30),
      child: ListView.builder(
        itemBuilder: (context,i){
          return InkWell(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: query == ""? Text(
                "${rooms[i]}",
                style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ) : Text(
                "${filter[i]}",
                style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            onTap: (){
              selectRooms.clear();
              if(query != filter[i]){
                query = filter[i];
                if(query != ""){
                  int i=0;
                  while("room: ${Rooms[i]['roomnum']}" != query){
                    i++;
                  }
                  String n = Rooms[i]['roomnum'].toString();
                   selectRooms.add(Rooms[i]);
                }
                showResults(context);
              }
              else{
                if(query != ""){
                  int i=0;
                  while("room: ${Rooms[i]['room']}" != query){
                    i++;
                  }
                   selectRooms.add(Rooms[i]);
                }
                showResults(context);
              }
            },
          );
        },
        itemCount: query == ""? rooms.length: filter.length,
      ),
    );

  }

}