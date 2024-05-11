import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class mysingup2 extends StatefulWidget {
  const mysingup2({super.key});

  @override
  State<mysingup2> createState() => _mysingup2State();
}
TextEditingController namecon = TextEditingController();
TextEditingController emailcon = TextEditingController();
TextEditingController passcon = TextEditingController();
class _mysingup2State extends State<mysingup2> {
  Future<void> mysing(String email,pass,name)async{
   UserCredential usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
   User user = usercredential.user!;
   await FirebaseFirestore.instance.collection('newhome').doc(user.uid).set({'Name':name,'Email':email});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FirePractise'),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namecon,
              decoration: InputDecoration(hintText: 'Name'),
            ),
             TextField(
              controller: emailcon,
              decoration: InputDecoration(hintText: 'Email'),
            ),
             TextField(
              controller: passcon,
              decoration: InputDecoration(hintText: 'pass'),
            ),
            ElevatedButton(onPressed: (){
              mysing(emailcon.text, passcon.text, namecon.text);
             
             setState(() {
                emailcon.clear();
              namecon.clear();
              passcon.clear();
             });
             
            }, child: Text('Signup'))
          ],
        ),
      ),
    );
  }
}