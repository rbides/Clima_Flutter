import 'package:location/location.dart';

class LocationBrain {

  double latitude;
  double longitude;

  
  Future<void> getCurrentlocation() async {
    //async / await is for the task to run on background so for a time consuming task it won't freenze the app
    // The highest the accuracy the more battery it will consume
    /*Position position =
        await Geolocator() // cound use a Feature<Position> without the await, if the data would be used in a future part of the code
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);*/

    try {
      Location location = Location();
      var position = await location.getLocation();
      latitude = position.latitude;
      longitude = position.longitude;
      
    } catch (e) {
      print(e);
    }
    // must get the user permissions
  }
}
