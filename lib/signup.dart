import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginandsignup/homepage.dart';
import 'package:loginandsignup/login.dart';

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
        print("The password is too weak");
      }
      else if(e.code=='email-already-in-use'){
        print("email already exists");
      }
    }
    return user;
  }
  var new_email=TextEditingController();
  var new_password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:300,
              child:TextField(
                controller: new_email,
                style:TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color:Colors.black),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.email_outlined,color: Colors.green,),
                    onPressed: (){},
                  ),
                  labelText:'Email Address',
                  hintText: "Enter your email",
                ),
              ),
            ),
            Container(
              width:250,
              height:10,
            ),
            Container(
              width:300,
              child:TextField(
                controller: new_password,
                obscureText: true,
                style:TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color:Colors.black),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.password_outlined,color: Colors.green,),
                    onPressed: (){},
                  ),
                  hintText: 'Enter new password',
                  labelText: "Password",
                ),
              ),
            ),
            const SizedBox(height:60,),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize: Size(300,50),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              child:Text('Sign-up'),
              onPressed:() async{
                User? user=await signupusingEmailPassword(email:new_email.text,password:new_password.text,context: context);
                print(user);
                if(user!=null){
                  Navigator.pop(context, MaterialPageRoute(builder: (context)=>login()));
                }
                else{
                  print("Yeh yaha nahi hai");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}