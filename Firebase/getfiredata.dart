import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:naapbook/Firebase/edit_screen.dart';
import 'package:naapbook/Firebase/loginfetch.dart';
class GetFiredata extends StatefulWidget {
  const GetFiredata({super.key});

  @override
  State<GetFiredata> createState() => _GetFiredataState();
}

class _GetFiredataState extends State<GetFiredata> {
  CollectionReference mycoll = FirebaseFirestore.instance.collection('naapbook');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: Text('Login'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if(value=='Profile'){
                print('Profile');
              }else if(value=="Logout"){
                print('logout');
              }
            },
            itemBuilder: (context) {
            return [
              PopupMenuItem(value: 'Profile',child: Text('profile')),
              PopupMenuItem(value: 'Logout',child: Text('Logout')),

            ];
          },)
        ],
      ),



      body: StreamBuilder(stream: mycoll.snapshots(), builder: (context,snapshot){
        if(snapshot.hasData){
          var data = snapshot.data!.docs;
          return ListView.builder(itemCount: data.length,itemBuilder: ((context, index) {
            return Card(child: Column(children: [
              Text(data[index]['Name']),
              Text(data[index]['Email']),
              IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>MyEdit(id: data[index].id)));
              }, icon: Icon(Icons.edit))
            ],),);
          }));
        }return Center(child: CircularProgressIndicator(),);
      }),
    );
  }
}