import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naapbook/Firebase/getfiredata.dart';
class FireSingup extends StatefulWidget {
  const FireSingup({super.key});
  @override
  State<FireSingup> createState() => _FireSingupState();
}
Future<void> myfiresing(String email,pass,name,gender)async{
  UserCredential usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
  User user = usercredential.user!;
  await FirebaseFirestore.instance.collection('naapbook').doc(user.uid).set({'Name':name,'Email':email,'Pass':pass,'Gender':gender});
}



Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}


String? gender = '';
TextEditingController emailfire = TextEditingController();
TextEditingController passfire = TextEditingController();
TextEditingController namefire = TextEditingController();
final forkey = GlobalKey<FormState>();
class _FireSingupState extends State<FireSingup> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: forkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextFormField(
              validator: (value) {
                if(value!.isEmpty){
         return 'Required';
                }return null;
              },
              
              controller: emailfire,
              decoration: InputDecoration(label: Text('Email'),hintText: 'Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),fillColor: Colors.white,filled: true),
            ),
            SizedBox(height: 10,),
             TextFormField(
              validator: (value) {
                if(value!.isEmpty){
         return 'Required';
                }return null;
              },
              controller: passfire,
              decoration: InputDecoration(hintText: 'Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),fillColor: Colors.white,filled: true),
            ),
            SizedBox(height: 10,),
             TextFormField(
              validator: (value) {
                if(value!.isEmpty){
         return 'Required';
                }return null;
              },
              controller: namefire,
              decoration: InputDecoration(hintText: 'Name',fillColor: Colors.white,filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            RadioListTile(value: 'Male', groupValue: gender,title: Text('male') ,onChanged: (value) {
              setState(() {
                gender=value;
              });
             
            },),
            RadioListTile(value: 'Female', groupValue: gender, title: Text('Female'),onChanged: (value) {
              setState(() {
                gender=value;
              });
              Title(color: Colors.green, child: Text('Male'));
            },),
            ElevatedButton(onPressed: (){
              if(forkey.currentState!.validate()){
  myfiresing(emailfire.text, passfire.text, namefire.text,gender);
              }
            
            }, child: Text('Singup')),
                                         
           InkWell(
            onTap: (){
              signInWithGoogle();
            },
             child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(25)),
              child: Center(child: Text('SignIn with Google'),),
             ),
           ),

          ],),
        ),
      ),
    );
  }
}