import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';

import '../notification/notification_service.dart';

class PersonAccountPage extends StatefulWidget {
  const PersonAccountPage({super.key});

  @override
  State<PersonAccountPage> createState() => _PersonAccountPageState();
}

class _PersonAccountPageState extends State<PersonAccountPage> {
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
        title: const Text(
            "your account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          InkWell(
            child: Container(
                height: 200,
                color: Colors.grey,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 120,top: 30),
                      child: IconButton(
                        icon: Icon(Icons.account_circle,size: 130,),
                        onPressed: (){
                          print("naeem");
                        },
                      ),
                    )
                  ],
                )
            ),
            onTap: (){
              print("abueideh");
            },
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 4,color: Colors.black,),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "name: ${selectAccount[0]['name']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                  ),
                  subtitle: InkWell(
                    onTap: (){
                      InfoAlertBox(
                        context: context,
                        title: "Future work",
                        infoMessage: "this option is ready soon"
                      );
                    },
                    child: const Text(
                      "if you have change your name click here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 4,color: Colors.black,),
          Container(
            child: Column(
              children: [
                ListTile(
                    title: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "email: ${selectAccount[0]['email']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: (){
                        InfoAlertBox(
                            context: context,
                            title: "Future work",
                            infoMessage: "this option is ready soon"
                        );
                      },
                      child: const Text(
                        "if you have change your email click here",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 4,color: Colors.black,),
          Container(
            child: Column(
              children: [
                ListTile(
                    title: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "password: ${selectAccount[0]['password']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: (){
                        InfoAlertBox(
                            context: context,
                            title: "Future work",
                            infoMessage: "this option is ready soon"
                        );
                      },
                      child: const Text(
                        "if you have change your password click here",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 4,color: Colors.black,),
          Container(
            child: Column(
              children: [
                ListTile(
                    title: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "phone number: ${selectAccount[0]['phone']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: (){
                        InfoAlertBox(
                            context: context,
                            title: "Future work",
                            infoMessage: "this option is ready soon"
                        );
                      },
                      child: const Text(
                        "if you have change your phone number click here",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 4,color: Colors.black,),
          const SizedBox(height: 10,),
          const Divider(thickness: 4,color: Colors.black,),

        ],
      ),
    );
  }
}
