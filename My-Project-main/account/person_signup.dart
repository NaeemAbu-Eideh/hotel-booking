// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';
import 'dart:convert';


class PersonSignUp extends StatefulWidget {
  const PersonSignUp({super.key});
  @override
  State<PersonSignUp> createState() => _PersonSignUpState();
}
class _PersonSignUpState extends State<PersonSignUp> {
  Map account = {};
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Signup",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/page.jpg"),
                fit: BoxFit.fill
            )
        ),
        child:  ListView(
          children: [
            Row(
              children: [
                const SizedBox(width: 50,),
                Container(
                  width: 120,
                  padding: const EdgeInsets.only(top: 100),
                  child: TextFormField(
                    controller: fName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),

                        ),
                        labelText: "first name*",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        )
                    ),

                  ),
                ),
                const SizedBox(width: 60,),
                Container(
                  width: 120,
                  padding: const EdgeInsets.only(top: 100),
                  child: TextFormField(
                    controller: lName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),

                        ),
                        labelText: "last name*",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        )
                    ),

                  ),
                ),

              ],
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 10,right: 40),
              child: TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  icon: Icon(Icons.email),
                  labelText: "email*",
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold

                  )

                ),
              ),

            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 10,right: 40),
              child: TextFormField(
                controller: password1,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  icon: Icon(Icons.password),
                  labelText: "password*",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),

                ),
              ),

            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 10,right: 40),
              child: TextFormField(
                obscureText: true,
                controller: password2,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  icon: Icon(Icons.password),
                  labelText: "password again*",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),

                ),
              ),

            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 10,right: 40),
              child: TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  icon: Icon(Icons.phone_iphone),
                  labelText: "phone number*",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),

                ),
              ),

            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(right: 40,left: 200),
              child: ElevatedButton(
                onPressed: () async{
                  if(fName.text == "" || lName.text == "" || email.text == ""
                      || password1.text == "" || password2.text == "" || phone.text == "") {
                    DangerAlertBox(
                      context: context,
                      title: "Wrong",
                      messageText: "miss in input data, please insert all data that contains *"
                    );
                  }
                  else{
                    if(password2.text != password1.text){
                      DangerAlertBox(
                          context: context,
                          title: "Wrong",
                          messageText: "first password can't equal second password"
                      );
                    }
                    else {
                      String? str = await getAccount(email.text);
                      if(!str!.isEmpty){
                        // ignore: use_build_context_synchronously
                        DangerAlertBox(
                          context: context,
                          title: "Wrong",
                          messageText: "this email is already found, enter another one"
                        );
                      }
                      else{
                        String? str = await getAccounts();
                        if(str == "" || str == null || str == "[]" || str!.isEmpty){
                          Map map = {
                            'fname':fName.text,
                            'lname':lName.text,
                            'email':email.text,
                            'pass':password1.text,
                            'phonenum':phone.text,
                            'type':"person"
                          };
                          await setAccount(map);
                          // ignore: use_build_context_synchronously
                          while(Navigator.of(context).canPop()){
                            Navigator.of(context).pop();
                          }
                          SuccessAlertBox(
                              context: context,
                              title: "Success",
                              messageText: "created"
                          );
                        }
                        else{
                          List list = [];
                          list.addAll(jsonDecode(str));
                          int i=0;
                          while(i < list.length && list[i]['phonenum'] != int.parse(phone.text)){i++;}
                          if(i == list.length){
                            Map map = {
                              'fname':fName.text,
                              'lname':lName.text,
                              'email':email.text,
                              'pass':password1.text,
                              'phonenum':phone.text,
                              'type':"person"
                            };
                            await setAccount(map);
                            // ignore: use_build_context_synchronously
                            while(Navigator.of(context).canPop()){
                              Navigator.of(context).pop();
                            }
                            SuccessAlertBox(
                                context: context,
                                title: "Success",
                                messageText: "created"
                            );
                          }
                          else{
                            // ignore: use_build_context_synchronously
                            DangerAlertBox(
                                context: context,
                                title: "Wrong",
                                messageText: "phone number is already found, enter another one"
                            );
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
                child: const Text(
                  "create",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),


          ],
        ),
      )
    );

  }
}
