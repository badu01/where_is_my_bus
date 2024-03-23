// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:where_is_my_bus/Widgets/Card.dart';

class ResultPage extends StatefulWidget {
  List buses;
  var From;
  var To;
  ResultPage({super.key,required this.buses, required this.From, required this.To});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 101, 143),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Text(widget.From,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            Icon(Icons.arrow_forward),
            Text(widget.To,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 3, 101, 143),
              Color.fromARGB(255, 3, 158, 106)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            itemCount: widget.buses.length,
            itemBuilder: ((context, index) =>BusCard(context,widget.buses[index],index) ),
            separatorBuilder: (ctx,index)=>SizedBox(height: 20,)),
        ),
      ) ,
    );
  }
}