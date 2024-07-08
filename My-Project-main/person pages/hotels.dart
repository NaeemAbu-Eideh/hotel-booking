import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/lists.dart';
import '../notification/notification_service.dart';



class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key});

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {

  bool refresh = false;
  Timer? timer;
  Future startTimer()async{}
  @override
  void initState() {
    hotel.clear();
    for(int i=0;i<Hotels.length;i++) {
      if (Hotels[i]['city']['name'] == info['city']) {
        hotel.add(Hotels[i]);
      }
    }
    mostRatedHotels.clear();
    hotel.sort((a, b) => b['rate'].compareTo(a['rate']));
    for(int i=0;i<10 && i < hotel.length;i++){
      mostRatedHotels.add(hotel[i]);
    }
    //----
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
              hotels.clear();
              for(int i=0;i<Hotels.length;i++){
                hotels.add(Hotels[i]['name']);
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
                hotel.clear();
                for(int i=0;i<Hotels.length;i++) {
                  if (Hotels[i]['city']['name'] == info['city']) {
                    hotel.add(Hotels[i]);
                  }
                }
                mostRatedHotels.clear();
                hotel.sort((a, b) => b['rate'].compareTo(a['rate']));
                for(int i=0;i<3 && i < hotel.length;i++){
                  mostRatedHotels.add(hotel[i]);
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
                title: selectAccount.isEmpty?  Text(
                  "you have not looged in to this page via an account, click on this icon to login",
                  style: TextStyle(color: Colors.white),
                ):
                Text(
                  "name: ${selectAccount[0]['name']}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.only(left: 15,right: 80),
                child: ElevatedButton(
                  onPressed: (){
                    hotels.clear();
                    for(int i=0;i<Hotels.length;i++){
                      hotels.add(Hotels[i]['name']);
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
                        "find a city",
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
      body:  refresh == true?  const Center(
        child: CircularProgressIndicator(),
      ) : Container(
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
                "all hotels",
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
                itemCount: hotel.length,
                itemBuilder: (BuildContext context, int subIndex) {
                  return Container(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: ListHotels(notes: hotel[subIndex],),
                  );
                },
              ),
            ),
            const SizedBox(height: 30,),
            const Divider(height: 4,color: Colors.black),
            const SizedBox(height: 30,),
            const Center(
              child: Text(
                "Top 10 rated hotels",
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
                  return ListHotels(notes: mostRatedHotels[i],);
                },
                itemCount: mostRatedHotels.length,
              ),
            ),
            const SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }
}

class ListHotels extends StatelessWidget{
  bool _isVertical = false;
  IconData? _selectedIcon;

  final notes;
  ListHotels({this.notes});
  @override
  Widget build(BuildContext context){
    return  Container(
      child: InkWell(
        onTap: (){
          info['hotel'] = notes['name'];
          info['hotel_rate'] = "${notes['rate']}";
         Navigator.of(context).pushNamed("rooms");
        },
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
                    "${notes["name"]}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),

                ),
                SizedBox(height: 20,),
                RatingBarIndicator(
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
                  "${selectHotels[0]['hotel']}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),

              ),
              SizedBox(height: 20,),
              RatingBarIndicator(
                rating: selectHotels[0]['rate'],
                itemBuilder: (context, index) => Icon(
                  _selectedIcon ?? Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 50.0,
                unratedColor: Colors.amber.withAlpha(50),
                direction: _isVertical ? Axis.vertical : Axis.horizontal,
              ),
              const SizedBox(height: 10,),
              Container(
                child: Text(
                  "rate: ${selectHotels[0]['rate']}/ 5.0",
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
        info['hotel'] = selectHotels[0]['name'];
        Navigator.of(context).pushNamed('rooms');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List filter = hotels.where((element) => element.contains(query)).toList();

    return Container(
      padding: const EdgeInsets.only(left: 30,top: 30),
      child: ListView.builder(
        itemBuilder: (context,i){
          return InkWell(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: query == ""? Text(
                "${hotels[i]}",
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
              selectHotels.clear();
              if(query != filter[i]){
                query = filter[i];
                if(query != ""){
                  int i=0;
                  while(Hotels[i]['name'] != query){
                    i++;
                  }
                  Map map = {
                    "country": Hotels[i]["city"]['country']['name'],
                    "hotel": Hotels[i]['name'],
                    "city":Hotels[i]["city"]['name'],
                    "rate": Hotels[i]["rate"],
                  };
                  selectHotels.add(map);
                }
                showResults(context);
              }
              else{
                if(query != ""){
                  int i=0;
                  while(Hotels[i]['name'] != query){
                    i++;
                  }
                  Map map = {
                    "country": Hotels[i]["city"]['country']['name'],
                    "hotel": Hotels[i]['name'],
                    "city":Hotels[i]["city"]['name'],
                    "rate": Hotels[i]["rate"],
                  };
                  selectHotels.add(map);
                }
                showResults(context);
              }
            },
          );
        },
        itemCount: query == ""? hotels.length: filter.length,
      ),
    );

  }

}