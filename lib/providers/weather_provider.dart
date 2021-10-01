import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  var client = http.Client();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _locationData;
  WeatherModel? model;

  Future refresh() async {
    await getLocation().then((value) async {
      await getWeather();
    });
  }

  Future getLocation() async {
    _isLoading = true;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _isLoading = false;
        notifyListeners();
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _isLoading = false;
        notifyListeners();
        return null;
      }
    }

    _locationData = await location.getLocation();
    //print(_locationData!.longitude);
    _isLoading = false;
    notifyListeners();
  }

  Future getWeather() async {
    if (_locationData == null) return;
    print(_locationData!.latitude);
    var lat = _locationData!.latitude;
    var lon = _locationData!.longitude;
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$APIKEY');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var body = response.body;
        //printWrapped(body);
        // print('1');
        model = WeatherModel.fromJson(jsonDecode(body));
      } else {
        print(response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
