import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(
      apiKey: "AIzaSyDTtb3sTqmNhFpy2TeRe0cT7OaBkb5gteo",
     appId: "1:1029814040433:web:77b96fef90bd39aad0e8d0", 
     messagingSenderId: "1029814040433", 
     projectId: "finalexamproject-c82e8")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insta Pay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AnimatedSplashScreen(splash: Image.asset('assets/images/logo2.png', width: 300, height: 300,), nextScreen: LoginPage(), duration: 800, splashIconSize: 200,),
    );
  }
}


