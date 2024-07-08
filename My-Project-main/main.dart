import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
 import 'package:hotel1/account/hotel_signup.dart';
 import 'package:hotel1/account/login.dart';
 import 'package:hotel1/account/person_signup.dart';
 import 'package:hotel1/account/set%20location.dart';
import 'package:hotel1/hotel%20pages/finish%20booking%20requests.dart';
import 'package:hotel1/hotel%20pages/hotelRoomInformation.dart';
import 'package:hotel1/hotel%20pages/receive%20messages.dart';
import 'package:hotel1/hotel%20pages/send%20messages.dart';
 import 'package:hotel1/person%20pages/account.dart';
 import 'package:hotel1/person%20pages/booking.dart';
 import 'package:hotel1/person%20pages/cities.dart';
 import 'package:hotel1/person%20pages/countries.dart';
 import 'package:hotel1/person%20pages/hotel%20information.dart';
 import 'package:hotel1/person%20pages/hotels.dart';
 import 'package:hotel1/person%20pages/map.dart';
import 'package:hotel1/person%20pages/rating.dart';
import 'package:hotel1/person%20pages/receive%20mesages.dart';
 import 'package:hotel1/person%20pages/reservation.dart';
 import 'package:hotel1/person%20pages/room%20information.dart';
 import 'package:hotel1/person%20pages/rooms.dart';
 import 'package:hotel1/hotel%20pages/accept%20requests.dart';
 import 'package:hotel1/hotel%20pages/account%20of%20hotel.dart';
 import 'package:hotel1/hotel%20pages/add%20room.dart';
 import 'package:hotel1/hotel%20pages/change%20hotel%20information.dart';
 import 'package:hotel1/hotel%20pages/change%20room%20information.dart';
 import 'package:hotel1/hotel%20pages/hotel%20information.dart';
 import 'package:hotel1/hotel%20pages/request.dart';
 import 'package:hotel1/hotel%20pages/room%20information.dart';
import 'package:hotel1/api.dart';
import 'package:hotel1/hotel%20pages/rooms.dart';
import 'package:hotel1/person%20pages/send%20messages.dart';
import 'notification/notification_service.dart';

void main()async{
  await refreshData();
  //-------

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
         "main": (context) => const MyHomePage(),
         "login": (context) => const Login(),
         "person_signup": (context) => const PersonSignUp(),
         "hotel_signup": (context) => const HotelSignUp(),
         "countries": (context)=> const CountriesPage(),
         "cities": (context) => const CitiesPage(),
         "hotels": (context)=> const HotelsPage(),
         "rooms": (context)=> const RoomsPage(),
         "yourBooking": (context)=> const BookingPage(),
         "informationOfRoom": (context)=> const InformationOfRoomPage(),
         "reservation": (context)=> const ReservationPage(),
         "hotelInformation": (context)=> const HotelInformationPage(),
         "roomInformation": (context)=> const RoomInformationPage(),
         "requestPage": (context)=> const RequestPage(),
         "acceptRequests":(context)=> const AcceptRequestPage(),
         "changeHotelInformation":(context) => const ChangeHotelInformationPage(),
         "changeRoomInformation":(context) => const ChangeRoomInformationPage(),
         "addRoom": (context)=> const AddRoomPage(),
         "personAccount": (context)=> const PersonAccountPage(),
         "informationOfHotel": (context)=> const InformationOfHotelPage(),
         "setLocation":(context)=> LocationPage(),
         "map":(context)=>const MapPage(),
         "hotelAccount":(context)=> const HotelAccountPage(),
         "hotelRoomsPage":(context)=> const HotelRoomsPage(),
         "personSendMessages": (context)=> const PersonSendMessagesPage(),
         "personReceiveMessages":(context)=> const PersonReceiveMessagesPage(),
         "hotelSendMessages":(context)=> const HotelSendMessagesPage(),
         "hotelReceiveMessages":(context)=> const HotelReceiveMessagesPage(),
         "rating":(context)=> const RatingPage(),
         "hotelRoomsInformationPage":(context)=> const InformationOfHotelRoomPage(),
         "finishBookingRequestsPage":(context)=> const FinishBookingRequestsPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        buttonTheme: const ButtonThemeData(buttonColor: Colors.blue,),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int ID = 1;
  bool refresh = false;

  Timer? timer;
  Future startTimer()async{
    timer = Timer.periodic(Duration(seconds: 7), (_) async {
      await refreshData();
    });
  }
  List<String> images = [
    'images/hotel.jpg',
    'images/hotel_outside.jpg',
    'images/hotel_room.jpeg',
  ];
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    //startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hotel Booking',style: TextStyle(color: Colors.white),),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () async {
                setState(() {
                  refresh = true;
                });
                await refreshData();
                setState(() {
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
        ),
        body: refresh == true?const Center(
          child: CircularProgressIndicator(),
        ):Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/page2.jpeg"),
                  fit: BoxFit.fill
              )
          ),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30,left: 20),
                child: const Text(
                  "Welcome, this application for booking hotels around the world, enjoy in your trip.",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: CarouselSlider(
                  items: images.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            image,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.map((image) {
                    int index = images.indexOf(image);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 100,),
              Container(
                height: 200,
                width: 100,
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: Image.asset(
                  "images/hotel1.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 100,),
              Container(
                height: 200,
                width: 100,
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: Image.asset(
                  "images/hotel2.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 100,),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "to be able to book rooms in hotels, you must login with your account",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 100,right: 100,),
                child: ElevatedButton(
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
                  ),
                ),

              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "if you don't have an account, create on",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 100,right: 100,top: 5),
                child: ElevatedButton(
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
                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                  ),
                  child: const Text(
                    "sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),

              ),
              Container(

                padding: const EdgeInsets.only(left: 40,right: 40,top: 5),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed("countries");
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                  ),
                  child: Text(
                    selectAccount.isEmpty? "or enter as a spectator": "enter to countries page",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 50,)

            ],
          ),
        ),
    );
  }
}