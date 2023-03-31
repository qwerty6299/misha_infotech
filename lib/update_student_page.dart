import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
   UpdateStudentPage({Key? key,required this.id}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formkey = GlobalKey<FormState>();
  CollectionReference ti =FirebaseFirestore.instance.collection("list");
  Future<void> updateuser(String id, String name){
 return ti.doc(id).update({"title":"$name"});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: Form(
        key: _formkey,
        child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
          future: FirebaseFirestore.instance.collection("list").doc(widget.id).get(),
          builder: (_,snapshot) {
            if(snapshot.hasError){
              print("something wrong");
            }
            if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
            }
            var data = snapshot.data!.data();
            var name = data!["title"];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: name,
                      autofocus: false,
                      onChanged: (value){
                    name=value;
                      },
                      decoration: InputDecoration(
                        labelText: 'title :',
                        labelStyle: TextStyle(
                          fontSize: 20
                        ),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15
                        )
                      ),
                      validator: (val){
                        if(val==null || val.isEmpty){
                          return 'Plase enter title';
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
                        updateuser(widget.id,name);
                        Navigator.pop(context);
                      }
                    }, child: Text('Update')),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                            onPressed: (){

                        }, child: Text('Reset'))
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
