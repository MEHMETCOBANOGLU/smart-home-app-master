import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:smart360/config/size_config.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/provider/base_view.dart';

import 'package:smart360/src/screens/add_environment/add_environment.dart';

import 'package:smart360/src/models/data_models/userModel.dart';

import 'package:smart360/src/screens/edit_profile/edit_profile.dart';
import 'package:smart360/src/screens/manage_environment/manage_environment_screen.dart';
import 'package:smart360/src/widgets/custom_bottom_nav_bar.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/body.dart';
import 'package:smart360/src/screens/menu_page/menu_screen.dart';

class HomeScreen extends StatefulHookWidget {
  static String routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String email, username, userId;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }
late UserModel user;
  gettingUserData() async {

    HelperFunctions hlp=HelperFunctions();
    hlp.initSP();
user=await hlp.getUserModel() as UserModel;
  
    setState(() {
      email = user.userEmail!;
      username = user.userName!;
      userId = user.userId!;

    });
  }

  Future<DataSnapshot> fetchData(String userId) async {
    DataSnapshot snapshot = await databaseReference.child('$userId').get();

    if (snapshot.exists) {
      // Child varsa, verisini alın ve kullanın
      return snapshot;
      // Veri işleme kodunu buraya ekleyin
    } else {
      // Child yoksa, userId numarasını kaydedin
      await databaseReference.child('$userId').child("devices").set({
        '34434232': {
          'components': {
            'isik': {'pinIOStatus': 1, 'pinNumber': 2, 'value': 0}
          },
          'config': {'place': "conf", 'title': "Akıllı Sistemler"}
        }
      });
      snapshot = await databaseReference.child('$userId').get();
    }

    return snapshot;
  }

  Future<Widget> db() async {
//  var s = await databaseReference
//         .child('$userId')
//         .get();

    //  var s=await fetchData(userId);
    var s = await fetchData(userId);

    return BaseView<HomeScreenViewModel>(
        onModelReady: (model) => {
              model.generateRandomNumber(),
            },
        builder: (context, model, child) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: getProportionateScreenHeight(60),
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                title: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          '$username',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xffdadada),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(45, 45)),
                        ),
                        child: IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            FontAwesomeIcons.solidUser,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamed(EditProfile.routeName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfile(),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    getProportionateScreenHeight(
                      35,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          dividerColor: Colors.amber,
                          //dividerHeight: 3,
                          isScrollable: true,
                          unselectedLabelColor: Colors.white.withOpacity(0.3),
                          indicatorColor: const Color(0xFF464646),
                          tabs: s.child("devices").children.map(
                            (child) {
                              return (Tab(
                                child: Row(
                                  children: [
                                    Text(
                                      child
                                          .child("config")
                                          .child("title")
                                          .value
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                              ));
                            },
                          ).toList(),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const addEnvironmentScreen(),
                                ));
                          },
                          icon: Icon(Icons.add_home_work_rounded))
                    ],
                  ),
                ),
              ),
              drawer: SizedBox(
                  width: getProportionateScreenWidth(270), child: const Menu()),
              body: TabBarView(
                children: s.child("devices").children.map(
                  (child) {
                    return (Body(
                      model: model,
                      uid: userId,
                      sn: child.key.toString(),
                    ));
                  },
                ).toList(),
              ),
              bottomNavigationBar: CustomBottomNavBar(model: model),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    useEffect(() {
      if (userId.isEmpty) {
        return () {
          Center(child: CircularProgressIndicator());
        };
      }

      return () {
        print('HomeScreen disposed');
      };
    }, []);

    return (FutureBuilder(
      future: db(),
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
    ));
  }
}
