import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_video/cat_clicked.dart';
import 'package:video_player/video_player.dart';


class Cat extends StatefulWidget {
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  List<String> cats = ['Love','Dosti','Festival','Old','Punjabi','Sad','Tv'];
  List<String> pics = [
    'images/love.jpg',
    'images/dosti.jpg',
    'images/festival.jpg',
    'images/old.jpg',
    'images/punjabi.jpg',
    'images/sad.jpg',
    'images/tv.jpg'
    ];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2), 
          itemCount: cats.length,
          itemBuilder: (ctx,i){
            
            return InkWell(
              onTap: (){

                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return Cat_clicked(index: i);
                    },

                ));
                
              },
              child: Stack(

                children: <Widget>[


                  Positioned.fill(
                    child: Card(
                      child: GridTile(

                          child: Image.asset(pics[i],fit: BoxFit.fill),
                          footer: Container(
                            color: Colors.black54,
                            child:Text(cats[i],
                              style: TextStyle(fontSize:15,color: Colors.white),
                            ) ,

                          )


                      ),
                      ),
                  ),




                ],

              )
              
              
            );
            
            
          }),
      
      
      
    );
  }
}

