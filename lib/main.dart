import 'package:chat_app/Group_Chat/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Group_Chat_App',
      debugShowCheckedModeBanner: false,
      home:HomePageScreen()
    );
  }
}
