import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/apicalls.dart';
import 'descriptionpage.dart';
import 'homepage.dart';
import 'login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;


class search_movie extends StatefulWidget {
  final String moviename;
  search_movie(@required this.moviename,{Key? key}) : super(key: key);

  @override
  State<search_movie> createState() => _search_movieState();
}

class _search_movieState extends State<search_movie> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var search=TextEditingController();
  List? listResponse;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
  }
  Future search_movie_()async{
    http.Response response;
    String moviename=widget.moviename.toString();
    response=await http.get(Uri.parse(search_header_()+"api_key="+apikey_()+"&query="+moviename));
    if(response.statusCode==200){
      var mapResponse=json.decode(response.body);
      setState((){
        // print(mapResponse);
        listResponse=mapResponse['results'];
      });
    }
    else{
      listResponse=null;
    }
  }
  @override
  void initState() {
    super.initState();
    search_movie_();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
      backgroundColor: Color.fromRGBO(21, 20, 20, 1.0),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20.w, 30.h, 0, 0),
            width:400.w,
            height:70.h,
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
                      // search_movie(search.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>search_movie(search.text.toString())));
                    },
                    icon: Icon(Icons.search_outlined,color: Colors.white,size: 27.sp),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height:double.infinity,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  if(
                  listResponse![index]['poster_path']==null ||
                      listResponse![index]['overview']==null ||
                      listResponse![index]['release_date']=="" ||
                      listResponse![index]['original_title']==null
                  ){
                    return Container();
                  }
                  return Container(
                    margin:EdgeInsets.fromLTRB(20.w, 0, 20.w, 0,),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              descriptionpage(listResponse![index]['original_title'],
                                  listResponse![index]['poster_path'],
                                  listResponse![index]['overview'],
                                  listResponse![index]['release_date'])));
                        },
                      child: Stack(
                        children: [
                          Container(
                            width:100.w,
                            child: Image(
                              image: NetworkImage(imageurl()+listResponse![index]['poster_path'].toString()),
                              width: 100.w,
                              height:100.h,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(100.w, 10.h, 0, 0),
                            width:300.w,
                            child: listResponse![index]['original_title'].toString().length<=30?
                            Text(listResponse![index]['original_title'].toString(),style:TextStyle(color: Colors.grey[400])):
                            Text(listResponse![index]['original_title'].toString().substring(0,20)+"...",style:TextStyle(color: Colors.grey[400],fontStyle: FontStyle.normal)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(100.w, 50.h, 0, 0),
                            width:300.w,
                            child: Text(listResponse![index]['release_date'].toString().substring(0,4),style:TextStyle(color: Colors.grey[300],fontStyle: FontStyle.normal)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: listResponse==null? 0:listResponse!.length,
                separatorBuilder: (context,index){
                  return Divider(height: 5.h,thickness: 0,);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
