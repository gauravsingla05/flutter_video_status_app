import 'package:flutter/material.dart';
import 'package:flutter_video/Admin.dart';
import 'package:flutter_video/showVideo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {




  Future<List> _getData() async{
    var url = await http.get("http://192.168.43.187/flutter/getdata.php");
    var jsondata = json.decode(url.body);

   return jsondata;


  }




  @override
  Widget build(BuildContext context) {

    return Container(
      child:  FutureBuilder(
          future: _getData(),
          builder: (ctx,ss){

            if(ss.hasError){

              Fluttertoast.showToast(msg: ss.error);
            }

            if(ss.hasData){

              return Items(list:ss.data);
            }
            else{
              return Container(child:Center(child: Text("Loading..."),));
            }



          }),
    );

    }
}


class Items extends StatelessWidget {
  List list;

  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(

        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: list==null?0:list.length,
        itemBuilder: (ctx,i){
          return InkWell(
            onTap: (){
              void _openAddEntryDialog() {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return ShowVideo(list: list,index:i);
                    },
                    fullscreenDialog: true
                ));
              }
               _openAddEntryDialog();
          },
            child: Stack(

              children: <Widget>[


                Positioned.fill(
                  child: Card(
                    child: GridTile(

                        child: Image.network(list[i]['thumb_url'],fit: BoxFit.fill),
                        footer: Container(
                          color: Colors.black54,
                          child:Text(
                              list[i]['title'], style: TextStyle(fontSize:15,color: Colors.white),
                          ) ,

                        )


                    ),
                  ),
                ),




              ],

            )
          );

        }



        );
  }
}










class Details{
  int id;
  String title;
  String singer;
  String cat;
  String video_url;
  String thumb_url;

  Details(this.id, this.title, this.singer,this.cat, this.video_url, this.thumb_url);


}
