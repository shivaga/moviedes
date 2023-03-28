import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:flutter/material.dart';
import 'package:loginandsignup/screens/descriptionpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginandsignup/screens/search_movie.dart';
import '../components/apicalls.dart';
import 'package:loginandsignup/screens/login.dart';
import 'package:loginandsignup/components/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List? listResponse ;
  List? listResponse1;
  List? listResponse2;
  List? listResponse3;
  late Timer timer;
  var search=TextEditingController();
  Future popular_movie() async {
    http.Response response;
    response = await http.get(Uri.parse(
        header_()+"popular?api_key="+apikey_()+"&language=en-US&page=1"));
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      setState((){
        listResponse = mapResponse!['results'];
      });
    }
    else{
      return ;
    }
  }
  Future top_rated_movie()async{
    http.Response response;
    response=await http.get(Uri.parse(header_()+"top_rated?api_key="+apikey_()+"&language=en-US&page=1"));
    if(response.statusCode==200){
      //stringResponse=response.body;
      var mapResponse=json.decode(response.body);
      setState((){
        listResponse1 = mapResponse!['results'];
      });
    }
    else{
      listResponse1=null;
    }
  }
  Future now_playing_movie()async{
    http.Response response;
    response=await http.get(Uri.parse(header_()+"now_playing?api_key="+apikey_()+"&language=en-US&page=1"));
    if(response.statusCode==200){
      var mapResponse=json.decode(response.body);
      setState((){
        listResponse2 = mapResponse!['results'];
      });
    }
    else{
      listResponse2=null;
    }
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
  }

  @override
  void initState() {
    super.initState();
    popular_movie();
    top_rated_movie();
    now_playing_movie();
    // timer= Timer.periodic(const Duration(milliseconds: 1000), (timer) {
    //   popular_movie();
    //   top_rated_movie();
    //   now_playing_movie();
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromRGBO(21, 20, 20, 1.0),
      drawer:Drawer(
        backgroundColor: Colors.black,
        child:Column(
          children: [
            Container(
              width: 300.w,
              margin: EdgeInsets.fromLTRB(30.w, 60.h, 0, 40.h),
              child: Row(
                children: [
                  Container(
                    width: 35.w,
                    height:35.h,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.w, 0, 20.w, 0),
                    child:Text("MoviePie",style: TextStyle(color:Colors.white,fontSize: 25.sp),)
                  ),
                  Container(
                    margin:EdgeInsets.fromLTRB(40.w, 0, 0,0),
                    child: IconButton(
                      onPressed: (){
                        scaffoldKey.currentState!.closeDrawer();
                      },
                      icon: Image.asset("icons/Icon-Hamburger-menu.png",color: Color.fromRGBO(
                          158, 158, 158, 1.0)),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              width:260.w,
              height:60.h,
              decoration: BoxDecoration(
                color:Color.fromRGBO(51, 51, 51, 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              child:TextField(
                controller: search,
                //obscureText: true,
                style:TextStyle(fontWeight: FontWeight.normal,color: Color.fromRGBO(
                    158, 158, 158, 1.0)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search_outlined,size: 27.sp,color: Colors.white,),
                  ),
                  hintText: "Search",
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          158, 158, 158, 1.0),
                    ),
                  )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30.w, 20.h, 0, 0),
              width: 300.w,
              child:Row(
                children: [
                  Icon(Icons.home_outlined,color: Colors.white,size: 25.sp),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  }, child: Text("Home",style: TextStyle(color: Color.fromRGBO(
                      158, 158, 158, 1.0),fontSize: 25.sp),))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30.w, 5.h, 0, 0),
              width: 300.w,
              child:Row(
                children: [
                  Icon(Icons.logout,color: Colors.white,size: 25.sp),
                  TextButton(onPressed: (){
                    signOut();
                  }, child: Text("Logout",style: TextStyle(color: Color.fromRGBO(
                      158, 158, 158, 1.0),fontSize: 25.sp),))
                ],
              ),
            ),
            Container(
              height:65.h,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.fromLTRB(0, 400.h, 0, 0),
              child: Column(
                children:[
                  Container(
                    width:300.w,
                    child:Text(FirebaseAuth.instance.currentUser?.displayName as String,style: TextStyle(color: Colors.white),),
                    margin: EdgeInsets.fromLTRB(40.w, 15.h, 0, 0),
                  ),
                  Container(
                    width:300.w,
                    margin: EdgeInsets.fromLTRB(40.w, 0, 0, 0),
                    child:Text(FirebaseAuth.instance.currentUser?.email as String,style: TextStyle(color:Colors.grey),),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children:[
              Container(
                margin: EdgeInsets.fromLTRB(20.w, 30.h, 0, 0),
                width:400.w,
                height:80.h,
                child: Row(
                  children: [
                    Container(
                      margin:EdgeInsets.fromLTRB(10.w, 0, 0,0),
                      child: IconButton(
                        onPressed: (){
                          scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Image.asset("icons/Icon-Hamburger-menu.png"),
                      ),
                    ),
                    Container(
                      width:230.w,
                      height:30.h,
                      padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:TextField(
                        controller: search,
                        //obscureText: true,
                        style:TextStyle(fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          // border:OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          hintText: "Search",
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>search_movie(search.text.toString())));
                        },
                        icon: Icon(Icons.search_outlined,color: Colors.white,size: 27.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width:340.w,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20.h),
                child:Text('Trending Movies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color:Colors.white,
                  ),
                ),
              ),
              Container(
                width:double.infinity,
                height:180.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                     if(listResponse==null){
                       return CircularProgressIndicator();
                      }
                      return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width:130.w,
                            child: ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                        descriptionpage(listResponse![index]['original_title'],
                                            listResponse![index]['poster_path'],
                                            listResponse![index]['overview'],
                                            listResponse![index]['release_date'])));
                                  },
                                  child: Image(
                                    image: NetworkImage(imageurl()+listResponse![index]['poster_path'].toString()),
                                    width: 100.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listResponse==null? 0:listResponse!.length,
                  separatorBuilder: (context,index){
                    return Divider(height: 30.h,thickness: 0,);
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width:340.w,
                child:Text('Top Rated Movies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color:Colors.white,
                  ),
                ),
              ),
              Container(
                width:double.infinity,
                height:180.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    if(listResponse1==null){
                      return CircularProgressIndicator();
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width:130.w,
                            child: ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>descriptionpage(listResponse1![index]['original_title'],listResponse1![index]['poster_path'],listResponse1![index]['overview'],listResponse1![index]['release_date'])));
                                  },
                                  child: Image(
                                    image: NetworkImage(imageurl()+listResponse1![index]['poster_path'].toString()),
                                    width: 100.w,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                  itemCount: listResponse1==null? 0:listResponse1!.length,
                  separatorBuilder: (context,index){
                    return Divider(height: 30.h,thickness: 0,);
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width:340.w,
                child:Text('Now Playing',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width:double.infinity,
                height:180.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    if(listResponse2==null){
                      return CircularProgressIndicator();
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width:130.w,
                            child: ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>descriptionpage(listResponse2![index]['original_title'],listResponse2![index]['poster_path'],listResponse2![index]['overview'],listResponse2![index]['release_date'])));
                                  },
                                  child: Image(
                                    image: NetworkImage(imageurl()+listResponse2![index]['poster_path'].toString()),
                                    width: 100.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listResponse2==null? 0:listResponse2!.length,
                  separatorBuilder: (context,index){
                    return Divider(height: 30.h,thickness: 0,);
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}



