import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginandsignup/login.dart';
import 'package:loginandsignup/homepage.dart';
import 'package:loginandsignup/signup.dart';

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
      if(e.code=="user-not-found"){
       print("No User found for that email");
      }
    }
    return user;
  }
  var email=TextEditingController();
  var password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:300,
                child:TextField(
                  controller: email,
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
                  controller: password,
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
                    hintText: 'Enter your password',
                    labelText: "Password",
                  ),
                ),
              ),
              const SizedBox(height:50,),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                  minimumSize: Size(300,50),
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                child:Text('Login'),
                onPressed:()async{
                  User? user=await loginusingEmailPassword(email:email.text,password:password.text,context: context);
                  print(user);
                  if(user!=null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  }
                  else{
                    print("Yeh yaha nahi hai");
                  }
                },
              ),
              Row(
                children:[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Signup',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>signup())),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ]
        ),
      ),
    );
  }
}
