import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginandsignup/screens/splashscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Mainpage());
}
class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(384.0, 811.2),
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) => snapshot.hasData
                ? const splashscreen(true)
                : const splashscreen(false),
          ),
        );
      },
    );
  }
}


