import 'package:firebase_database/firebase_database.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/screens/home_screen/components/property_popup.dart';
import 'package:smart360/src/screens/home_screen/components/savings_container.dart';
import 'package:smart360/src/screens/home_screen/components/weather_container.dart';

import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';

import 'dark_container.dart';

QuerryClass querry = QuerryClass();

class Body extends StatelessWidget {
  const Body(
      {Key? key, required this.model, required this.sn, required this.uid})
      : super(key: key);

  final HomeScreenViewModel model;
  final String sn;
  final String uid;

  Future<Widget> db(BuildContext context) async {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(7),
          vertical: getProportionateScreenHeight(7),
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
        ),
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            //   child: WeatherContainer(model: model),
            // ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              child: SavingsContainer(model: model),
            ),

            Divider(),
            Container(
              height: 410,
              child: FutureBuilder(
                future: querry.getDeviceCompList(uid, sn),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PropertyModel>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data!.map((e) {
                        return Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(5)),
                          child: DarkContainer(
                            propertyModel: e,
                            //itsOn: (e.pinVal == "0" ? false : true),
                            onTap: () {
                              // Handle fan switch

                              // TODO: set setting page  for  your  property
                            },
                            iconAsset: "assets/icons/menu_icons/devices.svg",


                            switchButton: () {
                              e.getUpdateFunc();
                              model.onRefresh();

                            },
                            isFav: false,
                            switchFav: () {},
                            //iconAsset: 'assets/icons/svg/fan.svg',
                            //device: e.propertyName!,
                            //switchFav: model.fanFav,
                            //isFav: model.isFanFav,
                            //sensorValue: "dennnnn",
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            // Row(children: [
            //   Expanded(
            //     child: Pdding(
            //       padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            //       child: DarkContaainer(
            //         itsOn: null,
            //         switchButton: () {},
            //         onTap: () {
            //           showDialog(
            //             context: context,
            //             builder: (context) {
            //               return PropertyPopup(
            //                 itsOn: false,
            //                 userId: uid,
            //                 deviceSn: sn,
            //                 propertyValue: 'Initial Value',
            //                 onSave: (newValue) {
            //                   // Handle property save
            //                 },
            //               );
            //             },
            //           );

            //           // TODO: set setting page  for  your  property
            //         },
            //         iconAsset: 'assets/icons/svg/info.svg',
            //         device: "Yeni Özellik Ekle",
            //         //deviceCount: 'Özellik eklemek için dokun',
            //         switchFav: () {},
            //         isFav: model.isFanFav,
            //         sensorValue: "deneme3",
            //       ),
            //     ),
            //   )
            // ]),
          ],
        ),
      ),
    );
  }

  //////
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: db(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return Center(child: Text('No data'));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PropertyPopup(
                itsOn: false,
                userId: uid,
                deviceSn: sn,
                propertyValue: 'Initial Value',
                onSave: (newValue) {
                  // Handle property save
                },
              );
            },
          );
        },
        backgroundColor: Colors.amber,
        heroTag: 'AlertDialog',
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.black),
            SizedBox(height: 2),
            Text("Özellik ",
                style: TextStyle(fontSize: 12, color: Colors.black)),
            SizedBox(height: 1),
            Text("ekle", style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
