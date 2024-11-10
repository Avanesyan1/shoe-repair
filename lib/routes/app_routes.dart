import 'package:flutter/material.dart';
import 'package:shoe_repair/screens/add/add_material_screen.dart';
import 'package:shoe_repair/screens/add/add_shoe_screen.dart';
import 'package:shoe_repair/screens/add/add_work_screen.dart';
import 'package:shoe_repair/screens/home/home_screen.dart';
import 'package:shoe_repair/screens/intro/intro_screen.dart';
import 'package:shoe_repair/screens/setting_screen.dart';
import 'package:shoe_repair/screens/show/show_material_screen.dart';
import 'package:shoe_repair/screens/show/show_shoe_screen.dart';
import 'package:shoe_repair/screens/show/show_work_screen.dart';

class AppRoutes {
  static const String introScreen = '/intro';
  static const String homeScreen = '/home';
  static const String addShoeScreen = '/add_shoe';
  static const String addWorkScreen = '/add_work';
  static const String addMaterialScreen = '/add_material';
  static const String showShoeScreen = '/show_shoe';
  static const String showMaterialScreen = '/show_material';
  static const String showWorkScreen = '/show_work';
  static const String settingScreen = '/setting';


  static final Map<String, WidgetBuilder> routes = {
    introScreen : (context) => const IntroScreen(),
    homeScreen : (context) => const HomeScreen(),
    addShoeScreen : (context) => const AddShoeScreen(),
    addMaterialScreen : (context) => const AddMaterialScreen(),
    addWorkScreen : (context) => const AddWorkScreen(),
    showShoeScreen : (context) => const ShowShoeScreen(),
    showMaterialScreen: (context) => const ShowMaterialScreen(),
    showWorkScreen: (context) => const ShowWorkScreen(),
    settingScreen: (context) => SettingScreen(),
  };
}