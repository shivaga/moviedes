import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginandsignup/screens/homepage.dart';
import 'package:loginandsignup/screens/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/google_sign_in.dart';

void main()=>runApp(MaterialApp(
    home:signup()
));
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  static Future<User?> signupusingEmailPassword ({required String email,required String password,required BuildContext context}) async{
    FirebaseAuth auth=FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential=await auth.createUserWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code=="weak-password"){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Password is too weak")));
      }
      else if(e.code=='email-already-in-use'){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User already exists")));
      }
    }
    return user;
  }
  var new_email=TextEditingController();
  var new_password=TextEditingController();
  var username=TextEditingController();
  FocusNode fieldone=FocusNode();
  FocusNode fieldtwo=FocusNode();
  FocusNode fieldthree=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(21, 20, 20, 1.0),
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0,80.h,0,30.h),
              width:226.w,
              height:200.h,
              decoration: BoxDecoration(
                color:Color.fromRGBO(217, 217, 217, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            Container(
              margin:EdgeInsets.fromLTRB(0, 0, 0, 15.h),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                      child:Text("MoviePie",style: TextStyle(color: Colors.white,fontSize: 30.sp,letterSpacing: 2),)
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                          left:BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.white),
                          top: BorderSide(color: Colors.white),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    margin:EdgeInsets.fromLTRB(120.w, 0, 0, 0),
                    child: TextButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
                        },
                        child: Text("Log In",style: TextStyle(color: Colors.white,fontSize: 15.sp),)
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(20.w, 0, 0, 20.h),
              child: Text("Create your account",style: TextStyle(color: Colors.white,fontSize: 20.sp,letterSpacing: 2),),
            ),
            Container(
              width:350.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15.h),
              child:TextFormField(
                controller: username,
                focusNode: fieldone,
                onFieldSubmitted: (value){
                   FocusScope.of(context).requestFocus(fieldtwo);
                },
                style:TextStyle(fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText:'Username',
                ),
              ),
            ),
            Container(
              width:350.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15.h),
              child:TextFormField(
                onFieldSubmitted: (value){
                  FocusScope.of(context).requestFocus(fieldthree);
                },
                controller: new_email,
                focusNode: fieldtwo,
                style:TextStyle(fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText:'Email Address',

                  ),
                ),
              ),
              Container(
                width:350.w,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15.h),
                child:TextFormField(
                  obscureText: true,
                  controller: new_password,
                  focusNode: fieldthree,
                  //obscureText: true,
                  style:TextStyle(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    hintText: "Password",
                  ),
                ),
              ),

              Container(
                width: 300.w,
                height:50.h,
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 10.h),
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(112, 95, 170, 1.0),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child:Text('Sign up'),
                  onPressed:() async{
                    if(username.text==""){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Username is required")));
                    }
                    else if(new_email.text==""){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Email is required")));
                    }
                    else if(!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@gmail.com")
                        .hasMatch(new_email.text)){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Enter correct email")));
                    }
                    else if(new_password.text==""){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Password is required")));
                    }
                    else {
                      User? user = await signupusingEmailPassword(
                          email: new_email.text,
                          password: new_password.text,
                          context: context);
                      user?.updateDisplayName(username.text);
                      print(user);
                      if (user != null) {
                        setState(() {
                          new_email.text="";
                          new_password.text="";
                          username.text="";
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text(
                            "Signup Completed.Login to proceed")));
                      }
                      else {}
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 35,0),
                      width: 100,
                      height: 1,
                      color: Colors.white,
                    ),
                    Container(
                      child: Text("OR",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 0,0),
                      width: 100,
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                width: 300.w,
                height:50.h,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white),
                      left:BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 15.h),
                child:ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(21, 20, 20, 1.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child:Text('Continue with Google'),
                  onPressed: ()async{
                    User? result=await Authentication.signInWithGoogle(context:context);
                    if(result==null){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Error occurred using Google Sign In. Try again.")));
                    }
                    else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                ),
              ),
            ],
          ),
      ),
      );
  }
}