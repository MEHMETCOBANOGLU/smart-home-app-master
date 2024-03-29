import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/screens/home_screen/components/property_container.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';

class LandingContainer extends StatelessWidget {
  const LandingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getProportionateScreenHeight(85),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFFFFFFF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(0),
              vertical: getProportionateScreenHeight(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Smart360'a hoşgeldiniz",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Kullanım kılavuzuna gözat',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.amber[200]),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    SizedBox(
                      width: 71,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Başla!"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[200],
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // <-- Radius
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: getProportionateScreenWidth(00),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Image.asset(
            'assets/images/landing.png',
            height: getProportionateScreenHeight(80),
            width: getProportionateScreenWidth(100),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
