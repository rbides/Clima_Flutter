import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      String data = response.body;

      //dynamic. We don't know what type of the data until we had decoded it
      return jsonDecode(data); // so we don't need to repeat the jsonDecode(data) for every field
    } else {
      print(response.statusCode);
    }
  }

}