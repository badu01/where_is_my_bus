// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget BusCard(context,busData) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    //height: 175.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                busData['number'],
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Rs.10',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Text(
            busData['name'],
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            children: [
              Image.asset(
                'Assets/images/bus_icon.png',
                height: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Text(
                    busData['from'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_forward,
                  size: 18,),
                  Text(
                    busData['to'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Arrival Time:10:25 am',
            style: TextStyle(
              color: Color.fromARGB(255, 1, 109, 55),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
