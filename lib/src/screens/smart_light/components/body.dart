import 'package:smart360/config/size_config.dart';
import 'package:smart360/view/smart_light_view_model.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final SmartLightViewModel model;
  const Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(19),
                top: getProportionateScreenHeight(7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(19),
                      top: getProportionateScreenHeight(7),
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
                              'Oturma\nOdası',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontSize: 40,
                                    color: const Color(0xFFBDBDBD)
                                        .withOpacity(0.5),
                                  ),
                            ),
                            Text(
                              'Oturma\nOdası',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(26),
                        ),
                        Text(
                          'Güç',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Switch.adaptive(
                          inactiveThumbColor: const Color(0xFFE4E4E4),
                          inactiveTrackColor: Colors.white,
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF464646),
                          value: model.isLightOff,
                          onChanged: (value) {
                            model.lightSwitch(value);
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Text(
                          'Renk',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(7),
                        ),
                        InkWell(
                          onTap: model.showColorPanel,
                          child: Image.asset(
                            'assets/images/color_wheel.png',
                            height: getProportionateScreenHeight(22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/lamp.png',
                  height: getProportionateScreenHeight(180),
                  width: getProportionateScreenWidth(140),
                  fit: BoxFit.contain,
                ),

                ///todo: Position this image in correct manner
                model.isLightOff
                    ? Image.asset(
                        model.lightImage,
                        height: getProportionateScreenHeight(190),
                        width: getProportionateScreenWidth(140),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      )
                    : SizedBox(
                        height: getProportionateScreenHeight(190),
                        width: getProportionateScreenWidth(140),
                      ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(
              15,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ton parlaklığı',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: getProportionateScreenHeight(9),
              ),
              Container(
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
                      width: getProportionateScreenWidth(115),
                      child: const Text(
                        'Sıcak',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(115),
                      child: const Text(
                        'Soğuk',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Yoğunluk',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    '${model.lightIntensity.toInt()}%',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: getProportionateScreenHeight(5),
                    thumbColor: const Color(0xFF464646),
                    activeTrackColor: const Color(0xFF464646),
                    inactiveTrackColor: Colors.white,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8)),
                child: Slider(
                  min: 0,
                  max: 100,
                  onChanged: (val) {
                    model.changeLightIntensity(val);
                  },
                  value: model.lightIntensity,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Off',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '100%',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
