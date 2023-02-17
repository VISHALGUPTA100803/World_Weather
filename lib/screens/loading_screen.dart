import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // initstate stateful widget build hone se pehle execute karke function dega
    // TODO: implement initState
    super.initState();
    getLocationData();

    print('this line of code is trigerred');
  }

  void getLocationData() async {
    // try {
    //   // somethingthatexceptslessthan10(12);
    //   LocationPermission permission = await Geolocator.requestPermission();
    //   Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.low);
    //   print(position);
    //   print(permission);
    // } catch (e) // (Exception)
    // {
    //   print(e);
    // }
    WeatherModel weathermodel = WeatherModel();
    var weatherData = await weathermodel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  // void getData() async {
  //   // http.Response response = await http.get(Uri.parse(
  //   //     'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
  //   //
  //   // if (response.statusCode == 200) {
  //   //   String data = response.body;
  //   //   print(data);
  //   //   var decodedData = jsonDecode(
  //   //       data); // var type is used because jsonDecode has dynamic data type
  //   double temperature =
  //       decodedData['main']['temp']; // main.temp (copy path from json)
  //   int condition = decodedData['weather'][0]['id']; // weather[0].id
  //   String cityname = decodedData['name']; // name
  //   print(temperature);
  //   print(condition);
  //   print(cityname);
  //   // } else {
  //   //   print(response.statusCode);
  //   // }
  // }
  // void somethingthatexceptslessthan10(int n) {
  //   if (n > 10) {
  //     throw 'n is greater than 10 it should be less than 10';
  //     // try and catch should always be used for using throw
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
