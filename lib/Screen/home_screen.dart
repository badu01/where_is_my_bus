// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_my_bus/Constants/Controllers.dart';
import 'package:where_is_my_bus/Screen/login_screen.dart';
import 'package:where_is_my_bus/Widgets/SearchFiled.dart';
import 'package:where_is_my_bus/firebase/function.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 101, 143),
        title: Row(
          children: [
            Image.asset('Assets/images/Logo_white.png',
            height: 30,),
            SizedBox(
              width: 5,
            ),
            Text('EazBus',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900
            ),),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.setBool('isloggedIn', false);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => LoginPage()),
                  (route) => false);
            },
            icon: Icon(Icons.logout_outlined,
            color: Colors.white,),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 3, 101, 143), Color.fromARGB(255, 3, 158, 106)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      // height: 350.0,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(31, 180, 175, 175),
                              spreadRadius: 8,
                              blurRadius: 7,
                              offset: Offset(0, 5)),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SearchField(
                                controller: FromController,
                                hint: 'Enter Starting location'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'To',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      String s = FromController.text;
                                      FromController.text = ToController.text;
                                      ToController.text = s;
                                    });
                                  },
                                  icon: Icon(Icons.swap_vert_circle),
                                  iconSize: 40,
                                  color: Color.fromARGB(255, 3, 101, 143),
                                  hoverColor: Colors.black,
                                )
                              ],
                            ),
                            SearchField(
                                controller: ToController,
                                hint: 'Enter  destination location'),
                            SizedBox(
                              height: 40,
                            ),
                            MaterialButton(
                              onPressed: () {
                                searchBus(context);
                              },
                              height: 50,
                              minWidth: 400,
                              color: Color.fromARGB(255, 3, 101, 143),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Find Bus",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                 // height: 125.0,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(31, 180, 175, 175),
                          spreadRadius: 8,
                          blurRadius: 7,
                          offset: Offset(0, 5)),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Search Bus',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          BusSerachField(controller: BusController, hint: 'Search Bus'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
