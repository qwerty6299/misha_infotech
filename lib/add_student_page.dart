import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formkey = GlobalKey<FormState>();
  CollectionReference ti =FirebaseFirestore.instance.collection("list");
  var name="";
  final namecontroller= TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    super.dispose();
  }
  cleartext(){
    namecontroller.clear();
  }
  Future<void> adduser(){
    return ti.add({"title":"$name"});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Title'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
          child: ListView(
            children: [
              Container(
              margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(

                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Title :',
                    labelStyle: TextStyle(
                      fontSize: 20
                    ),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15
                    ),

                  ),
                  controller: namecontroller,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter Title';
                    }
                    return null ;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          name=namecontroller.text;
                          adduser();
                          cleartext();
                          Navigator.pop(context);
                        });
                      }
                    }, child: Text('Register',style: TextStyle(
                      fontSize: 18.0
                    ),)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                        onPressed: (){
                     cleartext();
                    }, child: Text('Reset',style: TextStyle(
                        fontSize: 18.0
                    ),))
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
