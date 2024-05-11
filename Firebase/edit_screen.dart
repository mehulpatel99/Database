import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naapbook/Firebase/getfiredata.dart';
class MyEdit extends StatefulWidget {
  String id;
   MyEdit({super.key,required this.id});

  @override
  State<MyEdit> createState() => _MyEditState();
}

class _MyEditState extends State<MyEdit> {

  void getdata()async{
    var data = await FirebaseFirestore.instance.collection('naapbook').doc(widget.id).get();
    setState(() {
    nameupdate.text =data['Name'];
    emailupdate.text =data['Email'];
    });
  }
  void update(String? name,email)async{
    await FirebaseFirestore.instance.collection('naapbook').doc(widget.id).update({'Name':name,'Email':email});
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GetFiredata()));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  TextEditingController nameupdate = TextEditingController();
  TextEditingController emailupdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
            controller: nameupdate,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: emailupdate,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          ElevatedButton(onPressed: (){
            update(nameupdate.text, emailupdate.text);
          }, child: Text('Update'))
        ],),
      ),
    );
  }
}