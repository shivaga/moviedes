import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginandsignup/login.dart';
import 'package:loginandsignup/signup.dart';

void main(){
  runApp(MaterialApp(
      home:Home()
  ));
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future <FirebaseApp> _intializeFirebase() async{
    FirebaseApp firebaseApp=await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _intializeFirebase(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return login();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
