import 'package:finalyear/presentation/screens/homepage/homepage.dart';
import 'package:finalyear/presentation/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Sign In Sign Up ',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(216, 243, 220, 2),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: const HomePage(),
        home:  Splash(),
      ),
    );
  }
}
