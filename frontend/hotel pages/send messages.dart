import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import '../notification/notification_service.dart';

class HotelSendMessagesPage extends StatefulWidget {
  const HotelSendMessagesPage({super.key});
  @override
  State<HotelSendMessagesPage> createState() => _HotelSendMessagesPageState();
}
List hotelSendMessages = [];

class _HotelSendMessagesPageState extends State<HotelSendMessagesPage> {

  bool refresh = false;

  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    hotelSendMessages.clear();
    for (int i = 0; i < Messages.length; i++) {
      if (Messages[i]['send_from']['email'] == selectAccount[0]['email'] && Messages[i]['type'] == "send") {
        hotelSendMessages.add(Messages[i]);
      }
    }
    //------
    startTimer();
    super.initState();
  }
  sentMessagesNode(Map node){
    return  Container(
      padding: const EdgeInsets.only(bottom: 20,top: 20),
      color: Colors.black,
      child: Card(
        color: Colors.grey,
        child: Column(
          children: [
            ListTile(
              title: Text(
                "title: ${node['title']}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "body: ${node['body']}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListTile(
              title: Text(
                "sent to: ${node['send_to']['email']}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListTile(
                title: Column(
                  children: [
                    Text(
                      "sent date: ${node['date']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "sent day: ${node['time']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "sent time: ${node['houre']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),


                  ],
                )
            ),
            ElevatedButton(
              onPressed: () async{
                int id = -1;
                for(int i=0;i<hotelSendMessages.length;i++){
                  if(hotelSendMessages[i]['id'] == node['id']){id = int.parse("${node['id']}");}
                }
                if(id == -1){
                  DangerAlertBox(
                      context: context,
                      title: "Wrong",
                      messageText: "this message is not found"
                  );
                }
                else{
                  await deleteMessageById("$id");
                  setState(() {
                    int i=0;
                    while(i < hotelSendMessages.length && hotelSendMessages[i]['id'] != node['id']){
                      i++;
                    }
                    hotelSendMessages.removeAt(i);
                    Messages.removeAt(i);
                  });
                }
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
              ),
              child:const Text(
                "remove message",
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
          "Hotel Booking",
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
                hotelSendMessages.clear();
                for (int i = 0; i < Messages.length; i++) {
                  if (Messages[i]['send_from']['email'] == selectAccount[0]['email'] && Messages[i]['type'] == "send") {
                    hotelSendMessages.add(Messages[i]);
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
          IconButton(
            onPressed: () async {
              setState(() {
                refresh = true;
              });
              String str = await getMessages();
              if(str == "" || str.isEmpty){str = "[]";}
              List list = [];
              list.addAll(jsonDecode(str));
              hotelSendMessages.clear();
              for (int i = 0; i < list.length; i++) {
                if (list[i]['send_from']['email'] == selectAccount[0]['email'] && list[i]['type'] == "send") {
                  hotelSendMessages.add(list[i]);
                }
              }
              int i = 0;
              while(i < hotelSendMessages.length){
                await deleteMessageById("${hotelSendMessages[i]['id']}");
                i++;
              }
              setState(() {
                hotelSendMessages.clear();
                refresh = false;
              });
            },
            icon: const Row(
              children: [
                Text(
                  "remove all",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: Colors.black,
                ),
              ],
            )
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
                  child: sentMessagesNode(hotelSendMessages[i]));
            },
            itemCount: hotelSendMessages.length,)
      ),
    );
  }
}
