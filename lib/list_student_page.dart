import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mishainfotech/router/routename.dart';
import 'package:mishainfotech/update_student_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("list").snapshots();
  CollectionReference ti =FirebaseFirestore.instance.collection("list");
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
    installerStore: '',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> deleteuser(id) {
    return  ti.doc(id)
        .delete();
  }
  List checkBoxValue = List.generate(500, (index) => true);
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("  "),
                Text("${_packageInfo.version}"),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, Routesname.addstudentpage);
                  },
                  child: Padding(
                     padding: const EdgeInsets.only(right: 20.0),

                    child: Icon(Icons.add),
                  )
                )
              ],
            ),
          ),
          SizedBox(
            height:size.height*0.05 ,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasError){
                  print("something is wrong");
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Expanded(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitThreeBounce(
                          size: 20,

                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index.isEven ? Colors.redAccent :Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  );
                }
                final List storedocs=[];



                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String,dynamic>;


                  storedocs.add(a);

                  a["id"]= document.id;
                  print("fajf${a["id"]}");
                  print("theee${storedocs.length}");


                }).toList();
                return storedocs.length==0?Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('click  +  to add title ',style: TextStyle(
                        fontSize: 16
                      ),),
                    ],

                  ),
                ) :
                ListView(

                  shrinkWrap: true,

                  children: [

                    for(int i=0;i<storedocs.length;i++)
                      ...[
                Dismissible(

                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete),
                  ),
                  key: ValueKey(storedocs[i]),
                  onDismissed: (DismissDirection direction){
                    if(direction==DismissDirection.startToEnd) {
                      setState(() {
                        deleteuser(storedocs[i]["id"]);
                        storedocs.removeAt(i);
                      });

                    }
                    else if(direction==DismissDirection.endToStart){
                      setState(() {
                        deleteuser(storedocs[i]["id"]);
                        storedocs.removeAt(i);
                      });

                    }
                  },
                  child: Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GestureDetector(

                    onTap: (){
                    Navigator.push(context,  MaterialPageRoute(builder:
                    (BuildContext context)=>  UpdateStudentPage(id: '${storedocs[i]["id"]}',)));
                    },
                    child: Center(
                    child: Text(

                      '${storedocs[i]["title"]}',style: TextStyle(
                    fontSize: 18
                    ),),
                    )
                    ),
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
                    ),
                  ),
                ),
                        Divider(

                          color: Colors.black.withOpacity(0.6),
                        )


                      ]
                  ],
                );

              }
          ),
        ],
      ),
    );
  }

}