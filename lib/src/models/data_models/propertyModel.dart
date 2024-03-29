import 'dart:ui';


class PropertyModel {
<<<<<<< Updated upstream

String? propertyName="";  
String? iconUrl="";
String? pinNo="";
String? pinIO="";
String? pinVal="";

=======
  String? propertyName = "";
  String? pinNo = "";
  String? pinIO = "";
  String? pinVal = "";
  String? itsOn = "";
  String? propertyIcon = "";
  String? componentId = "";
>>>>>>> Stashed changes



<<<<<<< Updated upstream
Function({String? val})? updateFunc;

// VoidCallback? updateValue;


 PropertyModel({
     this. propertyName="",
     this. iconUrl="",
     this. pinNo="",
     this. pinIO="",
     this. pinVal="",
  
    // this.updateValue,
=======
  PropertyModel({
    this.propertyName = "",
    this.pinNo = "",
    this.pinIO = "",
    this.pinVal = "",
    this.itsOn = "",
    this.propertyIcon = "",
    this.componentId = "",
    this.updateValue,
>>>>>>> Stashed changes
    this.updateFunc,
  });

 Function({String? val}) get getUpdateFunc => this.updateFunc!;

 set setUpdateFunc(Function(String? updateFunc)) => this.updateFunc = updateFunc;

//  VoidCallback get getUpdateValue => this.updateValue!;

//  set setUpdateValue(VoidCallback updateValue) => this.updateValue = updateValue; 


  VoidCallback get getUpdateValue => this.updateValue!;

  set setUpdateValue(VoidCallback updateValue) =>
      this.updateValue = updateValue;

  String? get getPropertyName => this.propertyName;

  set setPropertyName(String? propertyName) => this.propertyName = propertyName;

  String? get getPinNo => this.pinNo;

  set setPinNo(String? pinNo) => this.pinNo = pinNo;

  String? get getPinIO => this.pinIO;

  set setPinIO(String? pinIO) => this.pinIO = pinIO;

  String? get getPinVal => this.pinVal;



  set setItsOn(String? itsOn) => this.itsOn = itsOn;
<<<<<<< Updated upstream
=======

  String? get getPropertyIcon => this.propertyIcon;

  set setPropertyIcon(String? propertyIcon) => this.propertyIcon = propertyIcon;

  String? get getComponentId => this.componentId;

  set setComponentId(String? componentId) => this.componentId = componentId;
>>>>>>> Stashed changes
}
