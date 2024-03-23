import 'package:flutter/material.dart';
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
        child: Text("this is splash"),
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
