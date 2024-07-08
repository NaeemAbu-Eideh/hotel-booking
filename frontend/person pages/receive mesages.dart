import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/person%20pages/send%20messages.dart';
import '../notification/notification_service.dart';

class PersonReceiveMessagesPage extends StatefulWidget {
  const PersonReceiveMessagesPage({super.key});
  @override
  State<PersonReceiveMessagesPage> createState() => _PersonReceiveMessagesPageState();
}
List personReceiveMessages = [];

class _PersonReceiveMessagesPageState extends State<PersonReceiveMessagesPage> {

  bool refresh = false;

  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    personReceiveMessages.clear();
    for (int i = 0; i < Messages.length; i++) {
      if (Messages[i]['send_to']['email'] == selectAccount[0]['email'] && Messages[i]['type'] == "receive") {
        personReceiveMessages.add(Messages[i]);
      }
    }
    //------
    startTimer();
    super.initState();
  }
  receivedMessagesNode(Map node){
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
                "sent from: ${node['send_from']['email']}",
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
                for(int i=0;i<personReceiveMessages.length;i++){
                  if(personReceiveMessages[i]['id'] == node['id']){id = int.parse("${node['id']}");}
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
                    while(i < personReceiveMessages.length && personReceiveMessages[i]['id'] != node['id']){
                      i++;
                    }
                    personReceiveMessages.removeAt(i);
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
                personReceiveMessages.clear();
                for (int i = 0; i < Messages.length; i++) {
                  if (Messages[i]['send_to']['email'] == selectAccount[0]['email'] && Messages[i]['type'] == "receive") {
                    personReceiveMessages.add(Messages[i]);
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
                personReceiveMessages.clear();
                for (int i = 0; i < list.length; i++) {
                  if (list[i]['send_to']['email'] == selectAccount[0]['email'] && list[i]['type'] == "receive") {
                    personReceiveMessages.add(list[i]);
                  }
                }
                int i = 0;
                while(i < personReceiveMessages.length){
                  await deleteMessageById("${personReceiveMessages[i]['id']}");
                  i++;
                }
                setState(() {
                  personReceiveMessages.clear();
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
                  child: receivedMessagesNode(personReceiveMessages[i]));
            },
            itemCount: personReceiveMessages.length,)
      ),
    );
  }
}
