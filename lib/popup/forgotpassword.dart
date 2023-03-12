import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginandsignup/screens/login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 146.h,
        width: 280.w,
        decoration:  const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(21, 20, 20, 1.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0.h),
              child: TextField(
                style: TextStyle(
                  color:Colors.white,
                ),
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 90.w,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        ),
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
                            158, 158, 158, 1.0)),
                      ),
                      onPressed: (){
                        FirebaseAuth.instance.sendPasswordResetEmail(email: nameController.text)
                            .then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Reset link sent.")));
                        })
                            .catchError(
                                (e) => print(e));
                      },
                      child: Text('Send Link',style: TextStyle(fontSize: 13.sp),)
                  ),
                ),
              ],
            ),
          ],

        )
    );
  }
}
