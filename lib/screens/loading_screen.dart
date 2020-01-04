import 'package:clima_flutter/screens/location_screen.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:flutter/material.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // first point on the widget's lifecycle, called when the state is initialized, created. Called only once
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
   
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  void deactivate() {
    // last point on the widget's lifecycle. Called when the widget is destroyed

    super.deactivate();
  }

  
  @override
  Widget build(BuildContext context) {
    /*second point on the widget's lifecycle. Called every time the widget is rebuilt
   ( everytime something changes on the screen). So its expensive to put code that will be repeated here (?)*/
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
