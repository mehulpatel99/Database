import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naapbook/Firebase/loginfetch.dart';
import 'package:path/path.dart';
class fireLogin extends StatefulWidget {
  const fireLogin({super.key});

  @override
  State<fireLogin> createState() => _fireLoginState();
}

Future<void> firelogin(String email,pass,BuildContext context)async{
  try{
    UserCredential usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
    User user = usercredential.user!;
    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginFetch(user: user)));
    print('succesfully login');
  }catch(e){
   print(e);
  }
}
TextEditingController emaillog = TextEditingController();
TextEditingController passlog = TextEditingController();
class _fireLoginState extends State<fireLogin> {
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
            firelogin(emaillog.text, passlog.text,context);
          }, child: Text('Login'))
        ],),
      ),
    );
  }
}