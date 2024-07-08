import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:hotel1/api.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController email = TextEditingController();
  List account = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
         leading: IconButton(
           onPressed: (){
             Navigator.of(context).pop();
           },
           icon: const Icon(Icons.arrow_back),
         ),
         title: const Text(
             "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "enter email or phone number",
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                controller: user,

              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "enter password",
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  icon: Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                ),
                controller: password,
                obscureText: true,

              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.only(left: 100),
                child:  Row(
                  children: [
                    const Text(
                      "if you forget password ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        email.text = "";
                        phone.text = "";
                        showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return Container(
                              height: 360,
                              width: 400,
                              child: Column(
                                children: [
                                  const SizedBox(height: 50,),
                                  const Text(
                                    "enter your email and phone number",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: TextFormField(
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: "email",
                                        labelStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                        icon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: TextFormField(
                                      controller: phone,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "phone",
                                        labelStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                        icon: Icon(Icons.numbers),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  ElevatedButton(
                                    onPressed: ()async{
                                      String? str = await findPassword(email.text,phone.text);
                                       // ignore: use_build_context_synchronously
                                       InfoAlertBox(
                                         context: context,
                                         title: "Password",
                                         infoMessage: "password is: ${str}"

                                       );
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                                    ),
                                    child: const Text("ok"),
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "click here",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                )
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: ()async{
                if(password.text == "" || user.text == ""){
                   DangerAlertBox(
                       context: context,
                       title: "Wrong",
                     messageText: "miss data, please enter (email or phone) and password together"
                   );
                 }
                else{
                   account.clear();
                   String? str = await getAccount(user.text);
                   // ignore: unnecessary_null_comparison
                   if(str == null){
                     // ignore: use_build_context_synchronously
                     DangerAlertBox(
                         context: context,
                         title: "Wrong",
                         messageText: "this account is not found"
                     );
                   }
                   else{
                     account.addAll(jsonDecode(str));
                     if(account[0]['pass'] != password.text){
                       // ignore: use_build_context_synchronously
                       DangerAlertBox(
                           context: context,
                           title: "Wrong",
                           messageText: "password is incorrect, please re-enter password",
                       );
                     }
                     else{
                       if(account[0]['type'] == "person"){
                         Map map = {
                           "email":account[0]['email'],
                           "password":account[0]['pass'],
                           "phone":account[0]['phonenum'],
                           "name":"${account[0]['fname']} ${account[0]['lname']}",
                           "image1":"",
                           "image2":""
                         };
                         selectAccount.clear();
                         selectAccount.add(map);
                         Navigator.of(context).pushNamed("countries");
                       }
                       else if(account[0]['type'] == "hotel"){
                         print(account);
                         Map map = {
                           "email":account[0]['email'],
                           "password":account[0]['pass'],
                           "phone":account[0]['phonenum'],
                           "name":account[0]['fname'],
                           "image1":"",
                         };
                         selectAccount.clear();
                         selectAccount.add(map);
                         Navigator.of(context).pushNamed("requestPage");
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
                "login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                "if you don't have account, create account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  showModalBottomSheet(
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
                                    fontSize: 20
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const SizedBox(width: 80,),
                                ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed("person_signup");
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
                                    Navigator.of(context).pushNamed("hotel_signup");
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
              child: const Text(
                "signup",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),

          ],

        ),
      ),
    );

  }
}
