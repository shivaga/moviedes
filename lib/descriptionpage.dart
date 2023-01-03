import 'package:flutter/material.dart';
import 'package:loginandsignup/descriptionpage.dart';

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
      appBar: AppBar(
        title:Text(widget.title1),
      ),
      body: Column(
        children: [
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
                title:Text('Release Date'),
                subtitle: Text(widget.releasedate1),
              ),
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListTile(
                title:Text('Overview'),
                subtitle: Text(widget.overview1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
