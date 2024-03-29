import 'package:flutter/material.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/service/weather_service.dart';
import 'package:smart360/src/models/weather_model.dart';

class WeatherContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WeatherModel>>(
      future: WeatherService().getWeatherData(),
      builder:
          (BuildContext context, AsyncSnapshot<List<WeatherModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildWeatherContainer(List.empty());
          //return  Row(children:[Text('Güncelleniyor...' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ),CircularProgressIndicator(color: Colors.amber,)]);
        } else if (snapshot.hasError) {
          return Text(
              "Bir Sorun oluştu Daha sonra tekrar deneyin."); // Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          List<WeatherModel> _weathers = snapshot.data!;
          return _buildWeatherContainer(_weathers);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildWeatherContainer(List<WeatherModel> _weathers) {
    if (_weathers.isEmpty) {
    return Stack(
      children: [
        Container(
          height: getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFFFFFFF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(5),
              vertical: getProportionateScreenHeight(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  child:  CircularProgressIndicator( color: Colors.amber,),
                ),
                Container(
                  width: getProportionateScreenWidth(150),
                  child: Column(
                    children: [
                      Text(
                        'Hava Durumu',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic ),
                      ),
                      Divider(),
                      Text(
                        ' °C',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                      ),
                      Text(
                        'Nem:  %',
                        style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold ),
                      ),
                      Text(

                        'Güncelleniyor..',
                   
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
 




    }

    return Stack(
      children: [
        Container(
          height: getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFFFFFFF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(5),
              vertical: getProportionateScreenHeight(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  _weathers[0].ikon,
                  height: getProportionateScreenHeight(100),
                  width: getProportionateScreenWidth(80),
                  fit: BoxFit.contain,
                ),
                Container(
                  width: getProportionateScreenWidth(100),
                  child: Column(
                    children: [
                      Text(
                        '${_weathers[0].gun.toUpperCase()}',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic ),
                      ),
                      Divider(),
                      Text(
                        '${_weathers[0].derece.toLowerCase()}  °C',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),
                      ),
                      Text(
                        'Nem:  ${_weathers[0].nem.toLowerCase()} %',
                        style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold ),
                      ),
                      Text(

                        '${_weathers[0].durum.toUpperCase()}',
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
 
 
 
  }
}
