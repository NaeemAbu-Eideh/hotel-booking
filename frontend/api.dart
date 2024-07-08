import 'package:http/http.dart' as http;
import 'dart:convert';


Map uri = {
  "path":"http://10.0.2.2:8555"
};
Map LocationMap = {
  "lon":"",
  "lat":"",

};

Map hotelAccount={};
Map info = {
  "country":"",
  "city":"",
  "hotel":"",
  "room":"",
  "roomPrice":"",
  "hotel_rate":""

};

Map roomFilter = {
  "highClass":"",
  "roomType":"",
  "bed":"",
  "separated":"",
};

Map book = {
  "id":"",
  "hotel_name":"",
  "room_number":"",
  "city_name":"",
  "country_name":"",
};
Map hotelPosition = {
  "country":"",
  "city":"",
};
Map RoomInformation = {
  "room":"",
  "hotel":"",
  "city":"",
  "room type":"",
  "high class":"",
  "number of beds":"",
  "if separated":"",
  "information":""
};

// ignore: non_constant_identifier_names
List Countries = [], Cities = [],Hotels = [], Rooms = [], Requests = []
// ignore: non_constant_identifier_names
, AcceptRequests = [], Booking = [], HotelsImages = [], RoomsImages = []
// ignore: non_constant_identifier_names
, Notifications = [], Messages = [], FinishBookingRequests = [];

List selectAccount=[];
//===================
Future refreshData()async{
  List list = [];
  Rooms.clear();
  Countries.clear();
  Cities.clear();
  Hotels.clear();
  Requests.clear();
  AcceptRequests.clear();
  Booking.clear();
  HotelsImages.clear();
  RoomsImages.clear();
  Notifications.clear();
  Messages.clear();
  FinishBookingRequests.clear();
  list.clear();
  //========================
  var str;
  str = await getCountries();
  if(str == null || str == ""){
    str = "[]";
  }
  Countries.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getCities();
  if(str == null || str == ""){
    str = "[]";
  }
  Cities.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getHotels();
  if(str == null || str == ""){
    str = "[]";
  }
  Hotels.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getRooms();
  if(str == null || str == ""){
    str = "[]";
  }
  Rooms.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getRequests();
  if(str == null || str == ""){
    str = "[]";
  }
  Requests.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getAcceptRequests();
  if(str == null || str == ""){
    str = "[]";
  }
  AcceptRequests.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getBookings();
  if(str == null || str == ""){
    str = "[]";
  }
  Booking.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getHotelsImages();
  if(str == null || str == ""){
    str = "[]";
  }
  list.addAll(jsonDecode(str));
  for(int i=0;i<list.length;i++){
    String image = await getHotelsImage(list[i]['name']);
    Map map = {
      "hotel":list[i]['hotel']['name'],
      "image":image
    };
    HotelsImages.add(map);
  }
  //-------
  list.clear();
  str = "";
  str = await getRoomsImages();
  if(str == null || str == ""){
    str = "[]";
  }
  list.addAll(jsonDecode(str));
  for(int i=0;i<list.length;i++){
    String image = await getRoomsImage(list[i]['name']);
    Map map = {
      "hotel":list[i]['hotel']['name'],
      "room":list[i]['roomnum'],
      "image":image,
    };
    RoomsImages.add(map);
  }
  //-------
  str = "";
  str = await getNotifications();
  if(str == null || str == ""){
    str = "[]";
  }
  Notifications.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getMessages();
  if(str == null || str == ""){
    str = "[]";
  }
  Messages.addAll(jsonDecode(str));
  //-------
  str = "";
  str = await getFinishBookingRequests();
  if(str == null || str == ""){
    str = "[]";
  }
  FinishBookingRequests.addAll(jsonDecode(str));

}
//===================
Future getAccounts()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/logincons/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getAccount(String email) async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/logincons/gete?email=${email}'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future findPassword(String email,String phone)async {

  var request = http.Request('GET', Uri.parse('${uri['path']}/logincons/findpass?email=$email&phonenum=$phone'));
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future checkPassword(String email, String password)async{


  var request = http.Request('GET', Uri.parse('${uri['path']}/logincons/findep?email=$email&pass=$password'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    if(str == "founded"){
      return true;
    }
    else{
      return false;
    }
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setAccount(Map map) async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/logincons/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
//==================
Future getCountries()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/country/get'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }


}
Future getCountry(String country)async{


  var request = http.Request('GET', Uri.parse('${uri['path']}/country/getcountry?name=$country'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String? str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setCountry(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/country/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future updateCountryTotalRate(String name, double totalRate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/country/updatetotrate?name=$name&totrate=$totalRate'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update country total rate");
  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateCountryNumberRate(String name, double numberRate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/country/updatenumrate?name=$name&numrate=$numberRate'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update country number rate");
  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateCountryRate(String name, double rate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/country/updaterate?name=$name&rate=$rate'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update country rate");
  }
  else {
    print(response.reasonPhrase);
  }

}
//==================
Future getCities()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/city/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getCity(String country, String city)async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/city/getcity?country_name=$country&name=$city'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setCity(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/city/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future updateCityTotalRate(String name, String countryName, double totalRate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/city/updatetotrate?name=$name&totrate=$totalRate&country_name=$countryName'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update city total rate");
  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateCityNumberRate(String name, String countryName, double numberRate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/city/updatenumrate?name=$name&numrate=$numberRate&country_name=$countryName'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update city number rate");

  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateCityRate(String name, String countryName, double rate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/city/updaterate?name=$name&rate=$rate&country_name=$countryName'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update city rate");
  }
  else {
    print(response.reasonPhrase);
  }

}
//=================
Future getHotels()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/hotel/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getHotel(String hotelName)async{

  var request = http.Request('GET', Uri.parse('${uri['path']}/hotel/gethotel?name=$hotelName'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setHotel(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/hotel/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future updateHotelTotalRate(String name, double totalRate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/hotel/updatetotrate?name=$name&totrate=$totalRate'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update hotel total rate");
  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateHotelNumberRate(String name, double numberRate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/hotel/updatenumrate?name=$name&numrate=$numberRate'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update hotel number rate");
  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateHotelRate(String name, double rate)async{
  var request = http.Request('PUT', Uri.parse('${uri['path']}/hotel/updaterate?name=$name&rate=$rate'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print("update hotel rate");
  }
  else {
    print(response.reasonPhrase);
  }

}
//=================
Future getRooms()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/room/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }


}
Future setRoom(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/room/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future updateRoomReserved(String hotelName, String roomNumber, String reserved)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('PUT', Uri.parse('${uri['path']}/room/reserved?roomnum=$roomNumber&hotel_name=$hotelName&reserved=$reserved'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
//----------------
Future getRequests() async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/request/get'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setRequest(Map map) async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/request/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteRequest(String personName, String personEmail, String hotelName, String roomNumber)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/request/delete?person_name=$personName&person_email=$personEmail&hotel_name=$hotelName&roomnum=$roomNumber'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteRequestById(String id)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/request/deleteid?id=$id'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}
//================
Future getAcceptRequests()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/acceptrequest/get'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setAcceptRequests(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/acceptrequest/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteAcceptRequest(String personName, String personEmail, String hotelName, String roomNumber)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/acceptrequest/delete?person_name=$personName&person_email=$personEmail&hotel_name=$hotelName&roomnum=$roomNumber'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteAcceptRequestById(String id)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/acceptrequest/deleteid?id=$id'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}
//================
Future getBookings()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/booking/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setBooking(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/booking/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }


}
Future updateBookingAccepted(String personName,String personEmail,String hotelName,String roomNumber,String accepted, DateTime startDate, DateTime endDate)async{
  var request = http.Request('PUT', Uri.parse('http://localhost:8555/booking/accepted?person_name=$personName&person_email=$personEmail&hotel_name=$hotelName&roomnum=$roomNumber&accepted=$accepted&start_date=$startDate&end_date=$endDate'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteBooking(String personName, String personEmail, String hotelName, String roomNumber)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/booking/delete?person_name=$personName&person_email=$personEmail&hotel_name=$hotelName&roomnum=$roomNumber'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteBookingById(String id)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/booking/deleteid?id=$id'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}
Future updateBookingAcceptedById(String id, String accepted)async{
  var request = http.MultipartRequest('PUT', Uri.parse('${uri['path']}/booking/acceptedid?id=$id&accepted=$accepted'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }


}
//=================
Future setHotelImage(String imagePath, String hotel)async{
  var request = http.MultipartRequest('POST', Uri.parse('${uri['path']}/imagehotel/add'));
  request.fields.addAll({
    'hotel_name': hotel
  });
  request.files.add(await http.MultipartFile.fromPath('image', imagePath));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getHotelsImages()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/imagehotel/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getHotelsImage(String imageName)async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/imagehotel/get/$imageName'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = base64Encode(await response.stream.toBytes());
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
//=================
Future setRoomImage(String imagePath, String hotel, String roomNumber)async{
  var request = http.MultipartRequest('POST', Uri.parse('${uri['path']}/imageroom/add'));
  request.fields.addAll({
    'hotel_name': hotel,
    'roomnum': roomNumber
  });
  request.files.add(await http.MultipartFile.fromPath('image', imagePath));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getRoomsImages()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/imageroom/get'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future getRoomsImage(String imageName)async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/imageroom/get/$imageName'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = base64Encode(await response.stream.toBytes());
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
//=================
Future getNotifications()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/notification/get'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setNotification(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/notification/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteNotification(String sendToEmail, String sendFromEmail, String title, String body, String type)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/notification/delete?send_to_email=$sendToEmail&send_from_email=$sendFromEmail&title=$title&body=$body&type=$type'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
//=================
Future getMessages()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/messages/get'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setMessage(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/messages/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteMessage(String sendToEmail, String sendFromEmail, String title, String body)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/messages/delete?send_from_email=$sendFromEmail&send_to_email=$sendToEmail&title=$title&body=$body'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteMessageById(String id)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/messages/deleteid?id=$id'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
//=================
Future getFinishBookingRequests()async{
  var request = http.Request('GET', Uri.parse('${uri['path']}/finishrequest/get'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String str = await response.stream.bytesToString();
    return str;
  }
  else {
    print(response.reasonPhrase);
  }

}
Future setFinishBookingRequests(Map map)async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('${uri['path']}/finishrequest/add'));
  request.body = json.encode(map);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}
Future deleteFinishBookingRequestsById(String id)async{
  var request = http.Request('DELETE', Uri.parse('${uri['path']}/finishrequest/deleteid?id=$id'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}