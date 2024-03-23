// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:where_is_my_bus/Screen/signUp_screen.dart';
import 'package:where_is_my_bus/firebase/function.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  TextEditingController _email =TextEditingController();
  TextEditingController _pass =TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool _isKeyboard=MediaQuery.of(context).viewInsets.bottom>0;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.orange, Colors.yellow])),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child:!_isKeyboard? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text("Login",
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 18))
                    ]):SizedBox(),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: ListView(children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _pass,
                        obscuringCharacter: "*",
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: _obscureText
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.visibility_off_outlined))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text("Forget Password",
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 20),
                      MaterialButton(onPressed: () async{
                        var res= await signIn(_email.text, _pass.text, context);
                            if (res) {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
                            }
                            else{
                              print("sign up failed");
                            }
                           ;
                      },
                      color: Colors.orange,
                      height: 30,
                      minWidth: 50,
                      child: Text("Sign Up"),),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          Text("Don't have an account ?"),
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SignUpPage()));
                          }, child: Text("Sign Up"))
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ]),
     ),
);}
}