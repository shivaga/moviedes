import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginandsignup/components/google_sign_in.dart';
import 'package:loginandsignup/screens/homepage.dart';
import 'package:loginandsignup/screens/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../popup/forgotpassword.dart';
import '../popup/showpopup.dart';

void main()=>runApp(MaterialApp(
    home:login()
));
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  static Future<User?> loginusingEmailPassword ({required String email,required String password,required BuildContext context}) async{
    FirebaseAuth auth=FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){}
    }
    return user;
  }
  final GoogleSignIn googleSignIn=GoogleSignIn();
  var email=TextEditingController();
  var password=TextEditingController();
  FocusNode fieldone=FocusNode();
  FocusNode fieldtwo=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                margin:EdgeInsets.fromLTRB(0, 0, 0, 35.h),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup()));
                          },
                          child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 15.sp),)
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width:350.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30.h),
                child:TextFormField(
                  focusNode: fieldone,
                  onFieldSubmitted: (value){
                    FocusScope.of(context).requestFocus(fieldtwo);
                  },
                  controller: email,
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 7.h),
                child:TextField(
                  controller: password,
                  focusNode: fieldtwo,
                  obscureText: true,
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
                margin:EdgeInsets.fromLTRB(210.w, 0, 0, 10.h),
                child: TextButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) => const ShowPopUp(widgetcontent: ChangePassword(),),
                      );
                    },
                    child: Text("Forgot password?",style: TextStyle(color: Colors.white,fontSize: 15.sp),)
                ),
              ),
              Container(
                width: 300.w,
                height:50.h,
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 25.h),
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(112, 95, 170, 1.0),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child:Text('Log In'),
                  onPressed:()async{
                    if(email.text==""){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Email is required")));
                    }
                    else if(password.text==""){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(
                          "Password is required")));
                    }
                    else {
                      User? user = await loginusingEmailPassword(
                          email: email.text,
                          password: password.text,
                          context: context);
                      if (user != null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                      else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text(
                            "User not Found")));
                      }
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40.w, 0, 35.w,0),
                      width: 100.w,
                      height: 1,
                      color: Colors.white,
                    ),
                    Container(
                      child: Text("OR",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40.w, 0, 0,0),
                      width: 100.w,
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
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 25.h),
                child: ElevatedButton(
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
            ]
        ),
      ),
    );
  }
}
