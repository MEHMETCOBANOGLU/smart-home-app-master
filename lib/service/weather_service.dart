
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:smart360/src/models/weather_model.dart';

class WeatherService {
  Future<String> _getLocation1() async {
    // Kullanıcının konumu açık mı kontrol ettik
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error("Konum servisiniz kapalı");
    }

    // Kullanıcı konum izni vermiş mi kontrol ettik
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Konum izni vermemişse tekrar izin istedik
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Yine vermemişse hata döndürdük
        Future.error("Konum izni vermelisiniz");
      }
    }

    // Kullanıcının pozisyonunu aldık
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Kullanıcı pozisyonundan yerleşim noktasını bulduk
    final List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Şehrimizi yerleşim noktasından kaydettik
    final String? city = placemark[0].administrativeArea;

    if (city == null) Future.error("Bir sorun oluştu");

    return city!;
  }





 Future<String>  _getLocation() async {
  // Kullanıcının konumu açık mı kontrol ettik
  final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Future.error("Konum servisiniz kapalı");
  }

  // Kullanıcı konum izni vermiş mi kontrol ettik
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Konum izni vermemişse tekrar izin istedik
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Yine vermemişse hata döndürdük
      Future.error("Konum izni vermelisiniz");
    }
  }

  // Kullanıcının pozisyonunu aldık
  final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  // Kullanıcının konumundan şehir bilgisini aldık
  final List<Placemark> placemarks = await  placemarkFromCoordinates(position.latitude, position.longitude);

  // Şehrimizi yerleşim noktasından kaydettik
  final String city = placemarks.isNotEmpty ? placemarks[0].subAdministrativeArea! : "";

  return city;
}



  Future<List<WeatherModel>> getWeatherData() async {
    final String city = await _getLocation();

    final String url =
        "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    const Map<String, dynamic> headers = {
      "authorization": "apikey 6s1Xc3TKrG3rJdgtvkKtMn:0toQvfCltyO0qIIdmloiTy",
      "content-type": "application/json"
    };

    final dio = Dio();

    final response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }

    final List list = response.data['result'];

    final List<WeatherModel> weatherList =
        list.map((e) => WeatherModel.fromJson(e)).toList();

    return weatherList;
  }
}
