import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_permissions/simple_permissions.dart';


class ShowVideo extends StatefulWidget {
  List list;
  int index;

  
  ShowVideo({this.list,this.index});


  @override
  _ShowVideoState createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  VideoPlayerController _videoPlayerController;
  Response response;
  bool downloading = false;
  var progressvalue = "";
  Permission permission = Permission.WriteExternalStorage;


  Future<void> _downloadBtn() async{
   Dio dio = Dio();

   String dir = (await getApplicationDocumentsDirectory()).path;
     Fluttertoast.showToast(msg: dir);

     try{
       await dio.download("${widget.list[widget.index]['video_url']}",
           "${dir+"jj.mp4"}",
           onProgress:(rec,total){

             print("GOT: $rec");
             downloading = true;
             setState(() {
               progressvalue = ((rec/total)*100).toStringAsFixed(0)+"%";
             });

           }

       );


     }catch(e){
       print(e);
     }

     setState(() {
       downloading = false;
      Fluttertoast.showToast(msg: "Done");
     });




  }



  @override
  void dispose() {
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _dialVisible = true;

    return
      WillPopScope(
        onWillPop: null,
        child:  Scaffold(
          floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: _dialVisible,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.arrow_downward),
                backgroundColor: Colors.red,
                label: 'Save',
                onTap: _downloadBtn
            ),
            SpeedDialChild(
              child: Icon(Icons.whatshot),
              backgroundColor: Colors.blue,
              label: 'Whatsapp',
              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: Icon(Icons.keyboard_voice),
              backgroundColor: Colors.green,
              label: 'Third',
              onTap: () => print('THIRD CHILD'),)
          ],
        ),
          body:
          Scaffold(

            body: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Chewie(
                        _videoPlayerController =  VideoPlayerController.network("${widget.list[widget.index]['video_url']}"),
                        aspectRatio: 2 / 3.7,
                        autoPlay: true,
                        looping: true,

                      ),
                    ),
                    Center(
                      child:downloading?
                          Container(
                            color: Colors.black38,
                             child: Text("Downloading..."+progressvalue,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              )

                          )


                        : Text(""),)

                  ],

                ),




              ],
            ),


             )


        ) );


  }
}
