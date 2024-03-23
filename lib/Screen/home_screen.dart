// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:where_is_my_bus/Constants/Controllers.dart';
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orange, Colors.yellow],
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
                                  color: Colors.orange,
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
                            ElevatedButton(
                              onPressed: () {
                                searchBus(context);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(350, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                              ),
                              child: Text('Find Bus'),
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
                  height: 125.0,
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
                        TextField(
                          controller: t1,
                          decoration: InputDecoration(
                              hintText: 'Bus Name',
                              border: OutlineInputBorder(),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        t1.text = '';
                                        setState(() {
                                          t1;
                                        });
                                      },
                                      icon: Icon(Icons.close)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search)),
                                ],
                              )),
                        ),
                      ],
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
