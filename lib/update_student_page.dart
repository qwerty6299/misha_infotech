import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
   UpdateStudentPage({Key? key,required this.id}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formkey = GlobalKey<FormState>();
  bool boldpressed=false;
  bool underlinepressed=false;
  bool italicpressed=false;
  CollectionReference ti =FirebaseFirestore.instance.collection("list");
  Future<void> updateuser(String id, String name){
 return ti.doc(id).update({"title":"$name"});
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
       
        body: Form(
          key: _formkey,
          child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
            future: FirebaseFirestore.instance.collection("list").doc(widget.id).get(),
            builder: (_,snapshot) {
              if(snapshot.hasError){
                print("something wrong");
              }
              if(snapshot.connectionState==ConnectionState.waiting){
              return  SpinKitThreeBounce(
                size: 20,

                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven ? Colors.redAccent :Colors.black,
                    ),
                  );
                },
              );
              }
              var data = snapshot.data!.data();
              var name = data!["title"];
              var image = data!["image"];
              Timestamp t= data["time"] as Timestamp;
              var description = data!["description"];
              print("fgrg$image");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Text('$name',style: TextStyle(
                              fontSize: 16
                          ),),
                        ),
                      ),
                      Text("      ")
                    ],
                  ),
                 image==""?Container(): Container(
                   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    height: 200,
                      width: double.infinity,
                      child: Image.network("$image",fit: BoxFit.cover,)),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Text(
                      t!=null?  DateFormat('d MMM,    hh:mm a').format(t.toDate()):'',
                      style: TextStyle(
                        fontSize: 12,

                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text('$name',style: TextStyle(
                        fontSize: 16
                      ),),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Text('$description',style: TextStyle(
                          fontSize: 16
                      ),),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.format_bold),
                  //       onPressed: () => setState((){
                  //         boldpressed = ! boldpressed;
                  //       }),
                  //     ),
                  //     IconButton(
                  //       icon: Icon(Icons.format_underline),
                  //       onPressed: () => setState((){
                  //         underlinepressed = !underlinepressed;
                  //       }),
                  //     ),
                  //     IconButton(
                  //       icon: Icon(Icons.format_italic),
                  //       onPressed: () => setState(() {
                  //         italicpressed=!italicpressed ;
                  //       }),
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //   ElevatedButton(onPressed: (){
                  //     if(_formkey.currentState!.validate()){
                  //       updateuser(widget.id,name);
                  //       Navigator.pop(context);
                  //     }
                  //   }, child: Text('Update')),
                  //       ElevatedButton(
                  //         style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  //           onPressed: (){
                  //
                  //       }, child: Text('Reset'))
                  //     ],
                  //   ),
                  // )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
