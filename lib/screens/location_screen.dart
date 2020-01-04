import 'package:clima_flutter/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String cityName;
  WeatherModel weatherModel = WeatherModel();
  String weatherIcon;
  String weatherDescription;

  @override
  void initState() {
    super.initState();
    // Every state has a 'widget' which is the corresponding StatefulWidget of the current State
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData != null) {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        weatherIcon = weatherModel.getWeatherIcon(
            weatherData['weather'][0]['id']); //Use the condition Number
        weatherDescription = weatherModel.getMessage(temperature);
        cityName = weatherData['name'];
      } else {
        temperature = 0;
        weatherIcon = 'Error';
        weatherDescription = 'Unable to find location';
        cityName = 'Unknown';
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop)),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel
                          .getLocationWeather(); // must use await to avoid the line below being null, because it returns a future. This way the line below will wait for the result.
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData = await weatherModel
                            .getCityWeather(typedName); // must use await to avoid the line below being null, because it returns a future. This way the line below will wait for the result.
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '$weatherDescription in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
