import 'package:appanimation/Animation.dart';
import 'package:appanimation/CircleAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
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
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Custom Animation',
          theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.blue,
              useMaterial3: true),

          //Circlular Animation
          // home:  const CircleAnimation(),

          //upload Animation
          home: AnimationScreen(),
        );
      },
    );
  }
}
