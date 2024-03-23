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
        title: Row(
          children: [
            Text(widget.From),
            Icon(Icons.arrow_forward),
            Text(widget.To),
          ],
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: widget.buses.length,
          itemBuilder: ((context, index) =>BusCard(context,widget.buses[index]) ),
          separatorBuilder: (ctx,index)=>SizedBox(height: 30,)),
      ) ,
    );
  }
}