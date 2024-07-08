import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel1/api.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';


class HotelSignUp extends StatefulWidget {
  const HotelSignUp({super.key});

  @override
  State<HotelSignUp> createState() => _HotelSignUpState();
}



class _HotelSignUpState extends State<HotelSignUp> {

  Map account = {};
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController phone = TextEditingController();
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
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20,top: 100,right: 20),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),

                    ),
                    labelText: "hotel name*",
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                    icon: Icon(
                        Icons.drive_file_rename_outline,
                      size: 30,
                    ),
                    iconColor: Colors.black,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),

                  ),
                  labelText: "email*",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  icon: Icon(
                    Icons.email,
                    size: 30,
                  ),
                  iconColor: Colors.black,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: password1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),

                  ),
                  labelText: "password*",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  icon: Icon(
                    Icons.password,
                    size: 30,
                  ),
                  iconColor: Colors.black,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: password2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),

                  ),
                  labelText: "password again*",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  icon: Icon(
                    Icons.password,
                    size: 30,
                  ),
                  iconColor: Colors.black,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),

                  ),
                  labelText: "phone*",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  icon: Icon(
                    Icons.phone,
                    size: 30,
                  ),
                  iconColor: Colors.black,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(right: 40,left: 240),
              child: ElevatedButton(
                  onPressed: ()async{
                    if(name.text == "" || email.text == "" || password1.text == ""
                        || password2.text == "" || phone.text == ""){
                      DangerAlertBox(
                          context: context,
                          title: "Wrong",
                          messageText: "miss in input data, please insert all data that contains *"
                      );

                    }
                    else{
                      if(password1.text != password2.text){
                        DangerAlertBox(
                            context: context,
                            title: "Wrong",
                            messageText: "first password can't equal second password"
                        );
                      }
                      else{
                        String? str = await getAccount(email.text);
                        if(!str!.isEmpty){
                          // ignore: use_build_context_synchronously
                          DangerAlertBox(
                            context: context,
                            title: "Wrong",
                            messageText: "email is already found, enter another one"
                          );
                        }
                        else{
                          String? str = await getAccounts();
                          if(str == "" || str == null || str == "[]" || str!.isEmpty){
                            Map map = {
                              'fname':name.text,
                              'lname':"",
                              'email':email.text,
                              'pass':password1.text,
                              'phonenum':phone.text,
                              'type':"hotel"
                            };
                            hotelAccount = map;
                            await setAccount(map);
                            Navigator.of(context).pushReplacementNamed("hotelInformation");
                          }
                          else{
                            List list = [];
                            list.addAll(jsonDecode(str));
                            int i=0;
                            while(i < list.length && list[i]['phonenum'] != int.parse(phone.text)){i++;}
                            if(i == list.length){
                              Map map = {
                                'fname':name.text,
                                'lname':"",
                                'email':email.text,
                                'pass':password1.text,
                                'phonenum':phone.text,
                                'type':"hotel"
                              };
                              hotelAccount = map;
                              await setAccount(map);
                              Navigator.of(context).pushReplacementNamed("hotelInformation");
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
                  child: const Row(
                    children: [
                      Text(
                        "next ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_outlined),
                    ],
                  )

              ),
            ),
            const SizedBox(height: 40,),

          ],
        ),
      ),
      //backgroundColor: Colors.black,

    );

  }
}
