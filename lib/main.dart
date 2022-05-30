import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hacker_news/screens/home_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
      ProviderScope(
          child: MyApp()
      ));
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

