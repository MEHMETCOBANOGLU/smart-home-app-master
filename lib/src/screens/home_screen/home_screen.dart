import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/provider/base_view.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/models/data_models/userModel.dart';
import 'package:smart360/src/screens/edit_profile/edit_profile.dart';
import 'package:smart360/src/screens/manage_environment/manage_environment_screen.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/body.dart';
import 'package:smart360/src/screens/menu_page/menu_screen.dart';

QuerryClass querry = QuerryClass();

class HomeScreen extends StatefulHookWidget {
  static String routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String email, username, userId;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  late UserModel user;
  gettingUserData() async {
    HelperFunctions hlp = HelperFunctions();
    hlp.initSP();
    UserModel user = await hlp.getUserModel() as UserModel;

    setState(() {
      email = user.userEmail!;
      username = user.userName!;
      userId = user.userId!;
    });
  }

  Future<Widget> db() async {
//  var s = await databaseReference
//         .child('$userId')
//         .get();

    //  var s=await fetchData(userId);
    var s = await querry.fetchData(userId);

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
                          "${username}",
                          style: Theme.of(context).textTheme.displayLarge,
                             overflow: TextOverflow.ellipsis,
                          maxLines: 2,
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
                      FutureBuilder(
                        future: querry.getTabsName(userId),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: TabBar(
                                dividerColor: Colors.amber,
                                //dividerHeight: 3,
                                isScrollable: true,
                                unselectedLabelColor:
                                    Colors.white.withOpacity(0.3),
                                indicatorColor: const Color(0xFF464646),
                                tabs: snapshot.data!.map(
                                  (tmp) {
                                    return (Tab(
                                      child: Row(
                                        children: [
                                          Text(
                                            tmp,
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
                            );
                          } else {
                            return Expanded  (child: Center (child:CircularProgressIndicator(color: Colors.amber)));
                          }
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      //addEnvironmentScreen(userId:userId),
                                      ManageEnvScreen(),
                                ));
                          },
                          icon: Icon(Icons.add_home_work_rounded))
                    ],
                  ),
                ),
              ),
              drawer: SizedBox(
                  width: getProportionateScreenWidth(270), child: const Menu()),
              body: FutureBuilder(
                future: querry.getTabsBody(userId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return TabBarView(
                        children: snapshot.data!.map(
                      (e) {
                        return (Body(
                          model: model,
                          uid: userId,
                          sn: e,
                        ));
                      },
                    ).toList());
                  } else {
                    return  Center (child:CircularProgressIndicator(color: Colors.amber,));
                  }
                },
              ),

              // s.child("devices").children.map(
              //   (child) {
              //     return (Body(
              //       model: model,
              //       uid: userId,
              //       sn: child.key.toString(),
              //     ));
              //   },
              // ).toList(),

              //bottomNavigationBar: CustomBottomNavBar(model: model),
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
