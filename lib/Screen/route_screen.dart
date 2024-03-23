//

// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:where_is_my_bus/Screen/layout_screen.dart';

class BusRoute extends StatefulWidget {
  var bus;
  BusRoute({super.key, required this.bus});

  @override
  State<BusRoute> createState() => _BusRouteState();
}

class _BusRouteState extends State<BusRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bus['name']),
        backgroundColor: Color.fromARGB(255, 3, 101, 143),
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SeatLayout()));
          }, icon: Icon(Icons.bus_alert_sharp))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            child: ListView.builder(
                controller: ScrollController(keepScrollOffset: true),
                shrinkWrap: true,
                itemCount: widget.bus['stops'].length,
                itemBuilder: (ctx, index) =>
                    routeCard(widget.bus, context, index)),
          ),
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 3, 101, 143),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bus Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Name: ${widget.bus["name"]}',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  Text('Name: ${widget.bus["number"]}',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

Widget routeCard(bus, context, index) {
  var x = bus['currLoc'] == bus['stops'][index] ? true : false;
  return Container(
    color: x ? Colors.lightGreen : Colors.white,
    width: MediaQuery.of(context).size.width * 1,
    height: 60,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              height: double.infinity,
              width: 5,
              color: Color.fromARGB(255, 3, 101, 143),
            ),
            x
                ? Icon(
                    Icons.bus_alert_sharp,
                    size: 30,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.circle,
                    size: 18,
                    color: Color.fromARGB(255, 3, 158, 106),
                  )
          ]),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: x
                ? MediaQuery.of(context).size.width * .80
                : MediaQuery.of(context).size.width * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bus['stops'][index],
                  style: TextStyle(
                      fontSize: 18, color: x ? Colors.white : Colors.black),
                ),
                Text(
                  '${10.00 + index * 5.2}0 AM',
                  style: TextStyle(color: x ? Colors.white : Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
