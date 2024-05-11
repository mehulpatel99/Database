import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginFetch extends StatefulWidget {
  User user;
   LoginFetch({super.key,required this.user});

  @override
  State<LoginFetch> createState() => _LoginFetchState();
}

class _LoginFetchState extends State<LoginFetch> {
  String? name1;
  String? email2;
  Future<void> loginget()async{
 var data = await FirebaseFirestore.instance.collection('naapbook').doc(widget.user.uid).get();
 setState(() {
    name1 = data['Name'];
    email2 = data['Email'];
 });
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginget();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('$name1'),
          Text('$email2')
        ],),
      ),
    );
  }
}