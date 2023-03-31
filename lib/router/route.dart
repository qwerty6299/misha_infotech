
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishainfotech/router/routename.dart';

import '../add_student_page.dart';
import '../main.dart';
import '../update_student_page.dart';



class Routes{
  static Route<dynamic> generateroute(RouteSettings settings){
    switch(settings.name){
      case Routesname.homepage:
        return MaterialPageRoute(builder: (BuildContext context)=> const MyHomePage());
      case Routesname.addstudentpage:
        return MaterialPageRoute(builder: (BuildContext context)=> const AddStudentPage());



        default : return  MaterialPageRoute(builder: (_)=> const Scaffold(
        body: Center(
          child: Text('no route',style: TextStyle(color: Colors.black),),
        ),
      ));

    }


  }

}