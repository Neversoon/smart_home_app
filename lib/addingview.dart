import 'package:flutter/widgets.dart';
import 'package:smart_home_app/ElectronicView.dart';
import 'package:smart_home_app/electroniccomponentinformation.dart';

abstract class AddingView extends ElectronicView{
  TextEditingController name = TextEditingController();

  ElectronicComponentInformation getData();
}
