import 'package:flutter/material.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/provider/base_model.dart';

import 'package:smart360/src/screens/menu_page/components/menu_list.dart';
import 'package:smart360/src/screens/menu_page/menu_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(child: 
    
      Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          bottom: getProportionateScreenHeight(12),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Menü',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                  ),
                  MenuList(),
                ],
              ),
            ),
          ],
        ))

    
    ,);
    
    
    }
}
