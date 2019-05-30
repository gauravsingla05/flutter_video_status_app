import 'package:flutter/material.dart';
import 'package:flutter_video/Admin.dart';
import 'package:flutter_video/showVideo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee_flutter/marquee_flutter.dart';


class Cat_clicked extends StatefulWidget {
  int index;


  Cat_clicked({this.index});

  @override
  _Cat_clickedState createState() => _Cat_clickedState();
}

class _Cat_clickedState extends State<Cat_clicked> {

  Future<List> _getData() async{
    var url ;
    if(widget.index==0){

      url = await http.get("http://192.168.43.187/flutter/get_love.php");

    }
    else if(widget.index==1){

      url = await http.get("http://192.168.43.187/flutter/get_dosti.php");

    }
    else if(widget.index==2){

      url = await http.get("http://192.168.43.187/flutter/get_festival.php");

    }
    else if(widget.index==3){

      url = await http.get("http://192.168.43.187/flutter/get_old.php");

    }
    else if(widget.index==4){

      url = await http.get("http://192.168.43.187/flutter/get_punjabi.php");

    }
    else if(widget.index==5){

      url = await http.get("http://192.168.43.187/flutter/get_sad.php");

    }
    else if(widget.index==6){

      url = await http.get("http://192.168.43.187/flutter/get_others.php");

    }



    var jsondata = json.decode(url.body);
    return jsondata;


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text("Cats"),
      ),
      body: FutureBuilder(
          future: _getData(),
          builder: (ctx,ss){

            if(ss.hasError){

              Fluttertoast.showToast(msg: ss.error);
            }

            if(ss.hasData){

              return Item(list:ss.data);
            }
            else{
              return Container(child:Center(child: Text("Loading..."),));
            }



          }),
    );

  }}

class Item extends StatelessWidget {
  List list;


  Item({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          itemCount: list==null?0:list.length,
          gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (c,i){
            return

              InkWell(
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
                child: Card(
                child: Column(

                  children: <Widget>[
                    Image.network(
                      list[i]['thumb_url'],height: 150, width: 170,fit: BoxFit.cover,),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                          color: Colors.black87,
                          child:
                          Text(
                            list[i]['title'],
                            style: TextStyle(
                                color: Colors.white
                            )
                            ,
                          )
                      ),
                    ),
                  ],),

            ),
              );

          }),


    );
  }
}
