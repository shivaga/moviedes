import 'package:flutter/material.dart';
import 'package:loginandsignup/screens/descriptionpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class descriptionpage extends StatefulWidget {
  final String title1;
  final String image1;
  final String overview1;
  final String releasedate1;
  const descriptionpage(
      @required this.title1,this.image1,this.overview1,this.releasedate1,
      {Key? key}) : super(key: key
  );

  @override
  State<descriptionpage> createState() => _descriptionpageState();
}

class _descriptionpageState extends State<descriptionpage> {
  var baseurl="https://image.tmdb.org/t/p/w500";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(21, 20, 20, 1.0),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
            child:Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back_ios_new_sharp,color:Colors.white)),
                Container(
                  margin: EdgeInsets.fromLTRB(85, 0, 0, 0),
                  child:Text("MoviePie",style: TextStyle(color: Colors.grey[400],fontSize: 27),)
                )
              ],
            ),
          ),
          Container(
            child: Image(
              image: NetworkImage(baseurl+widget.image1),
              width: 500,
              height: 300,
            ),
          ),
          SizedBox(
            height:20,
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListTile(
                title:Text('Release Date',style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),),
                subtitle: Text(widget.releasedate1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
              ),
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListTile(
                title:Text('Overview',style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),),
                subtitle: Text(widget.overview1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 1.5)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
