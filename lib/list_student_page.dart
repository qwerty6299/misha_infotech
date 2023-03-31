import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mishainfotech/router/routename.dart';
import 'package:mishainfotech/update_student_page.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("list").snapshots();
  CollectionReference ti =FirebaseFirestore.instance.collection("list");
  Future<void> deleteuser(id) {
    return  ti.doc(id)
        .delete();
  }
  List checkBoxValue = List.generate(500, (index) => true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError){
          print("something is wrong");
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final List storedocs=[];
        print("theee${storedocs.length}");
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String,dynamic>;
          storedocs.add(a);
          a["id"]= document.id;
          print("fajf${a["id"]}");


        }).toList();
          return storedocs.length==0?Center(
            child: Text('Add title to view List '),
          ) : Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const<int , TableColumnWidth>{
                1: FixedColumnWidth(140),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )),
                    TableCell(child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )),


                  ]
                ),
                for(var i=0;i<storedocs.length;i++)...[
                TableRow(
                    children: [
                      TableCell(child: Center(
                        child: Text('${storedocs[i]["title"]}',style: TextStyle(
                          fontSize: 18
                        ),),
                      )),
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context,  MaterialPageRoute(builder:
                                (BuildContext context)=>  UpdateStudentPage(id: '${storedocs[i]["id"]}',)));
                          //  Navigator.pushNamed(context, Routesname.updatestudentpage,arguments: );
                          }, icon:Icon(Icons.edit,color: Colors.orange,)),
                          Checkbox(
                              value: checkBoxValue[i],

                              activeColor: Colors.green,
                              onChanged:(bool? newValue){
                                deleteuser(storedocs[i]["id"]);
                                setState(() {
                                  checkBoxValue[i] = newValue!;
                                });
                              }),

                        ],
                      )),
                    ]
                ),
                      ]
              ],
            ),
          ),
        );
      }
    );
  }
}
