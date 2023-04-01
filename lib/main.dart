import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mishainfotech/router/route.dart';
import 'package:mishainfotech/router/routename.dart';


import 'list_student_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context , snapshot) {
        if(snapshot.hasError){
          print("something went wrong");
        }
        if(snapshot.connectionState==ConnectionState.done){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routesname.homepage,
            onGenerateRoute: Routes.generateroute,
          );
        }
        return CircularProgressIndicator();

      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListStudentPage(),

    );
  }
}
