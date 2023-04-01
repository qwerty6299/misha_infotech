import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mishainfotech/router/routename.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formkey = GlobalKey<FormState>();
  CollectionReference ti =FirebaseFirestore.instance.collection("list");
  var name="";
  var description="";
  bool boldpressed=false;
  bool underlinepressed=false;
  bool italicpressed=false;
  bool boldpressed1=false;
  bool underlinepressed1=false;
  bool italicpressed1=false;
  final namecontroller= TextEditingController();
  final descontroller= TextEditingController();
  bool isloading = false;
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
    return ti.add({"title":"$name","image" :"$downloadurl",
      "description":"$description",
      "time": FieldValue.serverTimestamp(),});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back)),
                  Text("Add data"),
                  Text('          ',style: TextStyle(
                      fontSize: 20
                  ),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
              child: GestureDetector(
                onTap: (){
                  imagepicker();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(

                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text('Upload image'),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 6,
                              child: Container(
                                height: 300,

                                decoration: BoxDecoration(

                                  border: Border.all( color: Colors.grey),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child:image==null? GestureDetector(
                                            onTap: (){
                                              imagepicker();
                                            },
                                            child: Center(
                                        child: Text('no image selected'),
                                      ),
                                          ): Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),

                                              ),
                                            width: double.infinity,
                                              child: Image.file(image!,fit: BoxFit.cover,))
                                      )
                                    ],
                                  ),
                                ),
                          )),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
              child: Container(


              margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 4,
                  minLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                    fontSize: 19,
                    fontWeight: boldpressed==false? FontWeight.normal:FontWeight.bold,
                    decoration: underlinepressed==false? TextDecoration.none : TextDecoration.underline,
                    fontStyle: italicpressed==false?FontStyle.normal : FontStyle.italic
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Title :',
                    labelStyle: TextStyle(
                      fontSize: 13
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
            ),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.format_bold),
          onPressed: () => setState((){
            boldpressed = ! boldpressed;
          }),
      ),
          IconButton(
            icon: Icon(Icons.format_underline),
            onPressed: () => setState((){
              underlinepressed = !underlinepressed;
            }),
          ),
          IconButton(
            icon: Icon(Icons.format_italic),
            onPressed: () => setState(() {
              italicpressed=!italicpressed ;
            }),
          ),
        ],
        ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
              child: Container(

                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 4,
                  minLines: 1,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontSize: 19,
                      fontWeight: boldpressed1==false? FontWeight.normal:FontWeight.bold,
                      decoration: underlinepressed1==false? TextDecoration.none : TextDecoration.underline,
                      fontStyle: italicpressed1==false?FontStyle.normal : FontStyle.italic
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Description  :',
                    labelStyle: TextStyle(
                        fontSize: 13
                    ),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15
                    ),

                  ),
                  controller: descontroller,
                  // validator: (value){
                  //   if(value==null || value.isEmpty){
                  //     return 'Please Enter De';
                  //   }
                  //   return null ;
                  // },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.format_bold),
                  onPressed: () => setState((){
                    boldpressed1 = ! boldpressed1;
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.format_underline),
                  onPressed: () => setState((){
                    underlinepressed1 = !underlinepressed1;
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.format_italic),
                  onPressed: () => setState(() {
                    italicpressed1=!italicpressed1 ;
                  }),
                ),
              ],
            ),
          SizedBox(
            height: 5,
          ),
          (namecontroller.text.toString().isNotEmpty && isloading==true) ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(
                  width: 8,
                ),
                Text('Uploading....',style: TextStyle(
                  color:Colors.black,
                ),)
              ],
            ):Container(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () async{
                      setState(() {
                        isloading=true;
                      });
                 image==null?null:  await  uploadimage();
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          name=namecontroller.text;
                          description= descontroller.text;
                          adduser();
                          cleartext();
                          Navigator.pushNamed(context, Routesname.homepage);
                          isloading=false;
                        });
                      }
                    }, child: Text('Register',style: TextStyle(
                      fontSize: 18.0
                    ),)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                        onPressed: (){
                     cleartext();
                     setState(() {
                       image=null;
                       namecontroller.text="";
                       descontroller.text = "";
                     });
                    }, child: Text('Reset',style: TextStyle(
                        fontSize: 18.0
                    ),))
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
  File? image;
  String downloadurl="";
  final picker = ImagePicker();
 Future imagepicker()async{
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
    if(pickedfile != null){
      image = File(pickedfile.path);
    }
    else{
      showsnackbar("No file selected", Duration(milliseconds: 300));
    }
    });
  }
  showsnackbar(String text , Duration d){
   final snacktest = SnackBar(content: Text('$text'),duration: d,);
   ScaffoldMessenger.of(context).showSnackBar(snacktest);
  }
  Future uploadimage()async{
  Reference ref = FirebaseStorage.instance.ref().child("images");
  await ref.putFile(image!);
  downloadurl = await ref.getDownloadURL();
  print("the downoaded url is $downloadurl");

  }
}
