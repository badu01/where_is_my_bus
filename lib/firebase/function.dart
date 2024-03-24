// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_my_bus/Constants/Constants.dart';
import 'package:where_is_my_bus/Constants/Controllers.dart';
import 'package:where_is_my_bus/Screen/home_screen.dart';
import 'package:where_is_my_bus/Screen/result_screen.dart';
import 'package:where_is_my_bus/Screen/route_screen.dart';

var db = FirebaseFirestore.instance;

void searchBus(BuildContext context) async {

  try {
    // Perform a query for buses containing the first stop
    QuerySnapshot fromQuerySnapshot = await db
        .collection("buses")
        .where("stops", arrayContains: FromController.text)
        .get();

    // Perform a query for buses containing the second stop
    QuerySnapshot toQuerySnapshot = await db
        .collection("buses")
        .where("stops", arrayContains: ToController.text)
        .get();

    // Extract lists of documents from the query results
    List<DocumentSnapshot> fromDocs = fromQuerySnapshot.docs;
    List<DocumentSnapshot> toDocs = toQuerySnapshot.docs;

    // Filter out buses that do not contain both stops
    List<DocumentSnapshot> commonDocs = [];
    for (var fromDoc in fromDocs) {
      for (var toDoc in toDocs) {
        if (fromDoc.id == toDoc.id) {
          commonDocs.add(fromDoc);
          break;
        }
      }
    }

    // Extract bus data from the common documents
    BusData = commonDocs.map((doc) => doc.data()).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ResultPage(buses: BusData,From: FromController.text,To: ToController.text,)));
    // Print or handle the common buses data
    // for (var busData in commonBusesData) {
    //   print(busData);
    // }
  } catch (error) {
    print("Error searching buses: $error");
  }
}



Future userRegEmail(emailAddress, password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}



signIn(email, pass, context) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
        credential.user!.updateDisplayName("badu");
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setBool('isloggedIn', true);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => MyHomePage()), (route) => false);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}


busNameSearch(context)async{
db.collection('buses').where('name',isEqualTo: BusController.text).get().then((value){
  var busDoc=value.docs;
  Busdetails = busDoc[0].data();
 // print(Busdetails['name']);
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>BusRoute(bus: Busdetails)));
});
}