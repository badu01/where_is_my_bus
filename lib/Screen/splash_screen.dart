import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_my_bus/Screen/home_screen.dart';
import 'package:where_is_my_bus/Screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    loginCheck(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/images/Splash_icon.png',
            height: 500,),
            SizedBox(height: 100,),
            LoadingAnimationWidget.twistingDots(leftDotColor: Color.fromARGB(255, 3, 101, 143), rightDotColor: Color.fromARGB(255, 3, 158, 106), size: 40),
            //LoadingAnimationWidget.fourRotatingDots(color:Color.fromARGB(255, 3, 101, 143) , size: 30)
          ],
        ),
      ),
    );
  }
}

isLoggedin()async{
        SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getBool('isloggedIn');
}

loginCheck(context)async{
  await  Future.delayed(Duration(seconds: 3));
    if(await isLoggedin()){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>MyHomePage()), (route) => false);
    }
    else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
    }
}
