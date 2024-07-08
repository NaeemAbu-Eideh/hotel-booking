// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:hotel1/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel1/api.dart';

import '../notification/notification_service.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  bool refresh = false;
  Timer? timer;
  Future startTimer()async{
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
  @override
  void initState() {
     mostRatedCountries.clear();
     Countries.sort((a, b) => b['rate'].compareTo(a['rate']));
     for(int i=0;i<10 && i < Countries.length;i++){
       mostRatedCountries.add(Countries[i]);
     }

    //------
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
                  while(Navigator.of(context).canPop() == true){
                    Navigator.of(context).pop();
                  }

                },
                icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                ),
            ),
            IconButton(
              onPressed: (){
                countries.clear();
                for(int i=0;i<Countries.length;i++){
                  countries.add(Countries[i]['name']);
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
                   mostRatedCountries.clear();
                   for(int i=0;i<3 && i < Countries.length;i++){
                     mostRatedCountries.add(Countries[i]);
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
                   title: selectAccount.isEmpty?  const Text(
                     "you have not logged in to this page via an account, click on this icon to login",
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
                   padding: const EdgeInsets.only(left: 15,right: 80),
                   child: ElevatedButton(
                     onPressed: (){
                       countries.clear();
                       for(int i=0;i<Countries.length;i++){
                         countries.add(Countries[i]['name']);
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
                           "find a country",
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
        body: refresh == true? const Center(
          child: CircularProgressIndicator(),
        ) :
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/page2.jpeg"),
                  fit: BoxFit.fill
              )
          ),
          child: ListView(
            children: [
              const SizedBox(height: 30,),
              const Center(
                child: Text(
                  "all countries",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Countries.length,
                  itemBuilder: (context,i) {
                    return Container(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: ListCountries(notes: Countries[i],),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30,),
              const Divider(height: 4,color: Colors.black),
              const SizedBox(height: 30,),
              const Center(
                child: Text(
                  "Top 10 rated countries",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,i){
                    return ListCountries(notes: mostRatedCountries[i],);
                  },
                  itemCount: mostRatedCountries.length,
                ),
              ),
              const SizedBox(height: 30,),

            ],
          ),
        ),
    );
  }
}

class ListCountries extends StatelessWidget{
  bool _isVertical = false;
  IconData? _selectedIcon;

  final notes;
   ListCountries({this.notes});
   @override
   Widget build(BuildContext context){
     return  Container(
       child: InkWell(
         onTap: (){
           info["country"] = notes['name'];
           Navigator.of(context).pushNamed("cities");
         },
         child: Card(
           color: Colors.black,
           child: Row(
             children: [
               Container(
                 height: 200,
                 width: 300,
                 child: Column(
                   children: [
                     SizedBox(height: 50,),
                     Container(
                       child: Text(
                         "${notes['name']}",
                         style: const TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           color: Colors.white
                         ),
                       ),

                     ),
                     SizedBox(height: 20,),
                     Container(
                       child: RatingBarIndicator(
                         rating: notes['rate'],
                         itemBuilder: (context, index) => Icon(
                           _selectedIcon ?? Icons.star,
                           color: Colors.amber,
                         ),
                         itemCount: 5,
                         itemSize: 50.0,
                         unratedColor: Colors.amber.withAlpha(50),
                         direction: _isVertical ? Axis.vertical : Axis.horizontal,
                       ),

                     ),
                     const SizedBox(height: 10,),
                     Container(
                       child: Text(
                         "rate: ${notes['rate']}/ 5.0",
                         style:const TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.bold,
                             color: Colors.white
                         ),
                       ),

                     ),
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
  bool _isVertical = false;
  IconData? _selectedIcon;
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
      child: Card(
        color: Colors.black,
        child: Container(
          height: 200,
          width: 300,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                child: Text(
                  "${selectCountry[0]['name']}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),

              ),
              SizedBox(height: 20,),
              Container(
                child: RatingBarIndicator(
                  rating: selectCountry[0]['rate'],
                  itemBuilder: (context, index) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 50.0,
                  unratedColor: Colors.amber.withAlpha(50),
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                ),

              ),
              const SizedBox(height: 10,),
              Container(
                child: Text(
                  "rate: ${selectCountry[0]['rate']}/ 5.0",
                  style:const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
      onTap: (){
        info['country'] = selectCountry[0]['name'];
        Navigator.of(context).pushNamed("cities");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filter = countries.where((element) => element.contains(query)).toList();

    return Container(
      padding: const EdgeInsets.only(left: 30,top: 30),
      child: ListView.builder(
        itemBuilder: (context,i){
          return InkWell(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: query == ""? Text(
                "${countries[i]}",
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
              selectCountry.clear();
              if(query != filter[i]){
                query = filter[i];
                if(query != ""){
                  int i=0;
                  while(Countries[i]['name'] != query){
                    i++;
                  }
                  selectCountry.clear();
                  Map map = {
                    "name": Countries[i]["name"],
                    "rate": Countries[i]["rate"],
                  };
                  selectCountry.add(map);
                }
                showResults(context);
              }
              else{
                if(query != ""){
                  int i=0;
                  while(Countries[i]['name'] != query){
                    i++;
                  }
                  Map map = {
                    "name": Countries[i]["name"],
                    "rate": Countries[i]["rate"],
                  };
                  selectCountry.add(map);
                }

                showResults(context);
              }
            },
          );
        },
        itemCount: query == ""? countries.length: filter.length,
      ),
    );
  }

}