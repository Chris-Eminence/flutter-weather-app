import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = 'b1e96b38c65dac6dc639da7eaa61c67c';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double longitude;
  late double latitude;

  @override
  void initState() {
    super.initState();
    print('initState called');
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = (location.latitude);
    longitude = (location.longitude);

    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey');
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodedData = jsonDecode(data);
      double temperature = decodedData(data)['main']['temp'];
      int condition = decodedData(data)['weather'][0]['id'];
      String cityName = decodedData(data)['name'];

      print('$temperature \n $condition \n $cityName');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
