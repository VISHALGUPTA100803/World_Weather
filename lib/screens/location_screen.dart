import 'package:weather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;

  late String cityname;
  late String weatherIcon;
  late String message;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget
        .locationWeather); // A State object's configuration is the corresponding StatefulWidget instance.
    // This property is initialized by the framework before calling initState.
    // If the parent updates this location in the tree to a new widget with the same runtimeType and Widget.key
    // as the current configuration, the framework will update this property to refer to the new widget and then call
    // didUpdateWidget, passing the old configuration as an argument.
    // So a state object configuration is the corresponding stateful widget instance if we tap into widget we will get acces
    // to locationscreen stateful widget
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityname = 'unable to get weather data';
        message = '';
        return; // it will end our function updateUI prematurely and prevent it from continuing
        // on to the next
      }
      double temp =
          weatherData['main']['temp']; // main.temp (copy path from json)
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id']; // weather[0].id
      weatherIcon = weather.getWeatherIcon(condition);

      cityname = weatherData['name']; //
      message = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather.getLocationWeather();
                      updateUI(weatherdata);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityname!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// double temperature = decodedData['main']['temp']; // main.temp (copy path from json)
// // int condition = decodedData['weather'][0]['id']; // weather[0].id
// // String cityname = decodedData['name']; // name
