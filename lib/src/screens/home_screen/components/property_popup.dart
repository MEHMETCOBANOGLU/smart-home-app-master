import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/models/theme.dart';
import 'package:smart360/src/screens/home_screen/components/body.dart';

class PropertyPopup extends StatefulWidget {
  final String userId;
  final String deviceSn;
  final PropertyModel propertyModel;

  final Function(String) onSave;

  const PropertyPopup({
    Key? key,
    required this.userId,
    required this.deviceSn,
    required this.propertyModel,
    required this.onSave,
  }) : super(key: key);

  @override
  _PropertyPopupState createState() => _PropertyPopupState();
}

class _PropertyPopupState extends State<PropertyPopup> {
  final PropertyModel propertyModel = PropertyModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, String>> components = [];
  Tema tema = Tema();
  late List<String> uri;
  late String propertyIcon;
  late String place = "";
  bool itsOn = false;
  String dropText = "Components Seçiniz";

  @override
  void initState() {
    super.initState();
    fetchComponents();
    itsOn = widget.propertyModel.pinVal == "0" ? false : true;
    propertyIcon = widget.propertyModel.propertyIcon!;
    //_newPropertyValue = widget.propertyValue;
  }

  Future<List<String>> _getlistIcons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final svgPaths = manifestMap.keys
        .where((String key) => key.contains('icons/device_icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();

    return svgPaths;

    // final imagePaths = manifestMap.keys
    //     .where((String key) => key.contains('images/'))
    //     .where((String key) => key.contains('.png'))
    //     .toList();

    // return imagePaths;
  }

  void fetchComponents() async {
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection('components').get();
    // List<String> fetchedComponents = [];
    // querySnapshot.docs.forEach((doc) {
    //   var cName = doc.id;
    //   if (cName != null) {
    //     fetchedComponents.add(cName.toString());
    //   }

    // });

    List<Map<String, String>> tmp = await querry.fetchedComponentsData();

    setState(() {
      components = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      backgroundColor: Colors.amber,
      title: Text(
        "Özellik Ekle  (${widget.deviceSn})",
        textAlign: TextAlign.center,
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.90,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: tema.inputBoxDec(boxColor: Colors.white),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    controller: TextEditingController(
                        text: widget.propertyModel.propertyName),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      } else {}
                      return null;
                    },
                    onSaved: (value) {
                      propertyModel.propertyName = value!;
                    },
                    decoration: tema.inputDec("Özellik adı ", Icons.abc),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(boxColor: Colors.white),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    controller:
                        TextEditingController(text: widget.propertyModel.pinNo),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      } else {}
                      return null;
                    },
                    onSaved: (value) {
                      propertyModel.pinNo = value!;
                    },
                    decoration: tema.inputDec(
                      "Pin Numarası",
                      Icons.cable,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(boxColor: Colors.white),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    controller: TextEditingController(
                        text: widget.propertyModel.pinVal),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      } else {}
                      return null;
                    },
                    onSaved: (value) {
                      propertyModel.pinVal = value!;
                    },
                    decoration: tema.inputDec(
                      "Varsayılan Değer",
                      Icons.data_array,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      menuMaxHeight: 150,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      hint: Row(children: [
                        const Icon(Icons.attractions),
                        Text(
                          dropText,
                        )
                      ]),
                      value: null,
                      onChanged: (String? newValue) {
                        // DropdownButton'da değer seçildiğinde yapılacak işlem
                      },
                      items: components.map((obj) {
                        return DropdownMenuItem<String>(
                          value: obj["id"],
                          child: Text(obj["name"].toString()),
                          onTap: () => {
                            setState(() {
                              dropText = obj["name"].toString();
                            })
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                    border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      width: 0,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text("İN-OUT Seçim"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(itsOn ? "Kontrol" : "Sensör"),
                            GestureDetector(
                              onTap: () => {
                                setState(() {
                                  itsOn = !itsOn;
                                })
                              },
                              child: Container(
                                width: 48,
                                height: 25.6,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: itsOn
                                      ? const Color.fromARGB(255, 239, 184, 73)
                                      : const Color(0xFF808080),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    width: 0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    itsOn ? const Spacer() : const SizedBox(),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                const Divider(),
                const Text(
                  "İkon Seçiniz:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    List<String> icons = await _getlistIcons();
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "İkon Seçiniz:",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 19),
                          ),

                          //backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: icons.map((icon) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            propertyIcon = icon;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: SvgPicture.asset(
                                          icon,
                                          width: 50,
                                          height: 50,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: propertyIcon == ""
                          ? SvgPicture.asset("assets/icons/svg/info.svg")
                          : SvgPicture.asset(propertyIcon)),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Kaydet',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              print(
                  "${propertyModel.propertyName},${itsOn},${propertyModel.pinNo},${propertyModel.pinVal}");
              //widget.onSave(_newPropertyValue);
              querry.saveDeviceComp(
                  widget.userId,
                  widget.deviceSn,
                  PropertyModel(
                      propertyName: propertyModel.propertyName,
                      itsOn: itsOn ? "1" : "0",
                      pinNo: propertyModel.pinNo,
                      pinIO: propertyModel.pinNo,
                      propertyIcon: propertyModel.getPropertyIcon));

              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
