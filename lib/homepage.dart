import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loginandsignup/descriptionpage.dart';
import 'package:http/http.dart' as http ;

void main()=>{
  runApp( MaterialApp(
      home:Home()
  ))
};
Map ?mapResponse;
List ?listResponse;
Map ?mapResponse1;
List ?listResponse1;
Map ?mapResponse2;
List ?listResponse2;
var baseurl="https://image.tmdb.org/t/p/w500";
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Future apicall()async{
    http.Response response;
    response=await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=0877e9afa975471b0a96f1e4a8c8622f&language=en-US&page=1"));
    if(response.statusCode==200){
      setState((){
        mapResponse=json.decode(response.body);
        listResponse=mapResponse!['results'];
      });
    }
  }
  Future apicall1()async{
    http.Response response1;
    response1=await http.get(Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=0877e9afa975471b0a96f1e4a8c8622f&language=en-US&page=1"));
    if(response1.statusCode==200){
      setState((){
        //stringResponse=response.body;
        mapResponse1=json.decode(response1.body);
        listResponse1=mapResponse1!['results'];
      });
    }
  }
  Future apicall2()async{
    http.Response response2;
    response2=await http.get(Uri.parse("https://api.themoviedb.org/3/movie/now_playing?api_key=0877e9afa975471b0a96f1e4a8c8622f&language=en-US&page=1"));
    if(response2.statusCode==200){
      setState((){
        //stringResponse=response.body;
        mapResponse2=json.decode(response2.body);
        listResponse2=mapResponse2!['results'];
      });
    }

  }

  @override
  void initState() {
    apicall();
    apicall1();
    apicall2();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieApp'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children:[
              SizedBox(
                width:double.infinity,
                child:Text('    Trending Movies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                width:double.infinity,
                height:200,
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
                            width:130,
                            child: ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>descriptionpage(listResponse![index]['original_title'],listResponse![index]['poster_path'],listResponse![index]['overview'],listResponse![index]['release_date'])));
                                  },
                                  child: Image(
                                    image: NetworkImage(baseurl+listResponse![index]['poster_path'].toString()),
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:100,
                            child: Text('${listResponse![index]['original_title']}',textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: listResponse==null? 0:listResponse!.length,
                  separatorBuilder: (context,index){
                    return Divider(height: 30,thickness: 0,);
                  },
                ),
              ),
              SizedBox(
                width:double.infinity,
                child:Text('    Top Rated Movies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                width:double.infinity,
                height:200,
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
                            width:130,
                            child: ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>descriptionpage(listResponse1![index]['original_title'],listResponse1![index]['poster_path'],listResponse1![index]['overview'],listResponse1![index]['release_date'])));
                                  },
                                  child: Image(
                                    image: NetworkImage(baseurl+listResponse1![index]['poster_path'].toString()),
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:100,
                            child: Text('${listResponse1![index]['original_title']}',textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: listResponse1==null? 0:listResponse1!.length,
                  separatorBuilder: (context,index){
                    return Divider(height: 30,thickness: 0,);
                  },
                ),
              ),
              SizedBox(
                width:double.infinity,
                child:Text('    Now Playing',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                width:double.infinity,
                height:200,
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
                            width:130,
                            child: ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>descriptionpage(listResponse2![index]['original_title'],listResponse2![index]['poster_path'],listResponse2![index]['overview'],listResponse2![index]['release_date'])));
                                  },
                                  child: Image(
                                    image: NetworkImage(baseurl+listResponse2![index]['poster_path'].toString()),
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:100,
                            child: Text('${listResponse2![index]['original_title']}',textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: listResponse2==null? 0:listResponse2!.length,
                  separatorBuilder: (context,index){
                    return Divider(height: 30,thickness: 0,);
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}


