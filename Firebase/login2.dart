import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naapbook/Firebase/getfiredata.dart';
import 'package:naapbook/Firebase/loginfetch2.dart';

class LoginFire2 extends StatefulWidget {
  const LoginFire2({super.key});

  @override
  State<LoginFire2> createState() => _LoginFire2State();
}
TextEditingController emaillog = TextEditingController();
TextEditingController passlog = TextEditingController();
class _LoginFire2State extends State<LoginFire2> {
  mylogin2(String email, pass) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      User user = usercredential.user!;
      Get.to(LoginFetch2(user: user,));
    } catch (e) {
      print(e);
      Get.snackbar('Inavalid', 'something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
            controller: emaillog,
            decoration: InputDecoration(hintText: 'Email'),
          ),
           TextField(
            controller: passlog,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          ElevatedButton(onPressed: (){
            mylogin2(emaillog.text, passlog.text);
          }, child: Text('Login'))
        ],),
      ),
    );
  }
}
