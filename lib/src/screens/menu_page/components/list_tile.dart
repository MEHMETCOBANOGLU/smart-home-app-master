import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart360/config/size_config.dart';
import 'package:flutter_svg/svg.dart';

class MenuListItems extends StatelessWidget {
  final String iconPath;
  final String itemName;
  final VoidCallback function;
  const MenuListItems({
    Key? key,
    required this.iconPath,
    required this.itemName,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          
          children: [
            SvgPicture.asset(iconPath,width: 30,height: 30,),
            SizedBox(
              width: getProportionateScreenWidth(25),
            ),
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
