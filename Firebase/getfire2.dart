import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GetFire2 extends StatefulWidget {
  const GetFire2({super.key});

  @override
  State<GetFire2> createState() => _GetFire2State();
}

class _GetFire2State extends State<GetFire2> {
  CollectionReference myfireget = FirebaseFirestore.instance.collection('newhome');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: myfireget.snapshots(), builder: ((context, snapshot) {
        if(snapshot.hasData){
          var data = snapshot.data!.docs;
          return ListView.builder(itemCount: data.length,itemBuilder: ((context, index) {
            return Card(child: Column(children: [
              Text('name = ${data[index]['Name']}'),
               Text('Email = ${data[index]['Email']}'),
            ],),);
          }));
        }return Center(child: CupertinoActivityIndicator(),);
      })),
    );
  }
}