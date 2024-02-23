import 'package:smart360/config/size_config.dart';
import 'package:smart360/view/smart_ac_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Body extends StatelessWidget {
  final SmartACViewModel model;
  const Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(19),
              top: getProportionateScreenHeight(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_outlined)),
                Stack(
                  children: [
                    Text(
                      'Klima\nSistemi',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 45,
                            color: const Color(0xFFBDBDBD).withOpacity(0.5),
                          ),
                    ),
                    Text(
                      'Oturma\nOdası',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SleekCircularSlider(
              min: 5,
              max: 40,
              initialValue: 23,
              appearance: CircularSliderAppearance(
                size: 200,
                startAngle: 250,
                angleRange: 360,
                customColors: CustomSliderColors(
                  trackColor: const Color(0xFFBDBDBD),
                  progressBarColor: const Color(0xFF464646),
                  // hideShadow: true,
                  shadowColor: const Color(0xFFBDBDBD).withOpacity(0.1),
                  shadowMaxOpacity: 1,
                  shadowStep: 25,
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 22,
                  handlerSize: 25,
                  trackWidth: 22,
                  shadowWidth: 50,
                ),
              ),
              onChange: (double value) {
                // callback providing a value while its being changed (with a pan gesture)
              },
              onChangeStart: (double startValue) {
                // callback providing a starting value (when a pan gesture starts)
              },
              onChangeEnd: (double endValue) {
                // ucallback providing an ending value (when a pan gesture ends)
              },
              innerWidget: (double value) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenHeight(12),
                    top: getProportionateScreenHeight(45),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${value.toInt()}°',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        'Santigrat',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Samsung AC',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Bağlandı',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              Switch.adaptive(
                inactiveThumbColor: const Color(0xFFE4E4E4),
                inactiveTrackColor: Colors.white,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF464646),
                value: model.isACon,
                onChanged: (value) {
                  model.acSwitch(value);
                },
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          // Divider(
          //   thickness: 2,
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Text(
            'Mod',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: ToggleButtons(
              selectedColor: Colors.white,
              fillColor: const Color(0xFF464646),
              renderBorder: false,
              borderRadius: BorderRadius.circular(15),
              textStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
              onPressed: (int index) {
                model.onToggleTapped(index);
              },
              isSelected: model.isSelected,
              children: <Widget>[
                SizedBox(
                  width: getProportionateScreenWidth(70),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/cool.svg',
                        color: model.isSelected[0]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Soğuk',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/air.svg',
                        color: model.isSelected[1]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Hava',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/sun.svg',
                        color: model.isSelected[2]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Sıcak',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/eco.svg',
                        color: model.isSelected[3]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Eko',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
        ],
      ),
    );
  }
}
