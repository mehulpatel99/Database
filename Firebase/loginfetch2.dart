import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginFetch2 extends StatefulWidget {
  User user;
   LoginFetch2({super.key,required this.user});

  @override
  State<LoginFetch2> createState() => _LoginFetch2State();
}

class _LoginFetch2State extends State<LoginFetch2> {
  String? name;
  String? email;
  getloginfetch()async{
    var data = await FirebaseFirestore.instance.collection('newhome').doc(widget.user.uid).get();
    setState(() {
      name=data['Name'];
      email=data['Email'];
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getloginfetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Name = $name'),
        Text('Email = $email')
      ],),
    );
  }
}