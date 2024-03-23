import 'package:flutter/material.dart';

class SeatLayout extends StatelessWidget {
  const SeatLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seats Layout',style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SafeArea(child: Image.asset('Assets/images/Bus_layout.png')),
    );
  }
}