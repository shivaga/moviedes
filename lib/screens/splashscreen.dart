import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginandsignup/screens/homepage.dart';
import 'package:loginandsignup/screens/login.dart';
import 'package:page_transition/page_transition.dart';


class splashscreen extends StatefulWidget {
  final bool loggedin;
  const splashscreen(this.loggedin, {super.key});


  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (!mounted) return;

    if (!widget.loggedin) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const login(), type: PageTransitionType.fade));
    } else {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const Home(), type: PageTransitionType.fade));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(21, 20, 20, 1.0),
        body: Center(
          child: Column(
            children: [
          Container(
          margin: EdgeInsets.fromLTRB(0,200.h,0,30.h),
          width:250.w,
          height:250.h,
          decoration: BoxDecoration(
            color:Color.fromRGBO(217, 217, 217, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          ),
              Container(
                child: Text("MoviePie",style: TextStyle(color: Colors.white,fontSize: 35.sp,letterSpacing: 5),),
              ),
            ],
          ),
        ),
    );
  }
}
