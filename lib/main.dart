import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mishainfotech/router/route.dart';
import 'package:mishainfotech/router/routename.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'list_student_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
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




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${_packageInfo.version}"),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, Routesname.addstudentpage);
            },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple
                ),
                child: Text('Add',style: TextStyle(
                  fontSize: 20
                ),))
          ],
        ),
      ),
      body: ListStudentPage(),

    );
  }
}
