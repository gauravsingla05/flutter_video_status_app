import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:thumbnails/thumbnails.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  var _filePath;
  File file,thumfile;
  var url = "http://192.168.43.187/flutter/add_data.php";
  var uploading_url = "http://192.168.43.187/flutter/upload.php";
  var thumb_uploading_url = "http://192.168.43.187/flutter/thumbupload.php";

  var video_files_url = "http://192.168.43.187/flutter/uploads/";
  var thumb_files_url = "http://192.168.43.187/flutter/uploads/thumbs/";

  static TextEditingController title = TextEditingController();
  static TextEditingController singer = TextEditingController();
  List _fruits = ["Romantic", "Sad", "Love", "Old", "Dosti","Punjabi","Festival","Others"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_fruits);
    _selectedFruit = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
  }





  Future _uploadData() async{

  String thumbName = randomAlpha(5);
    String thumb = await Thumbnails.getThumbnail(
         // creates the specified path if it doesnt exist
        videoFile:_filePath,
        imageType: ThumbFormat.PNG,
        quality: 30);





    thumfile = File(thumb);
   file = File(_filePath);
   var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
   var thumbstream = new http.ByteStream(DelegatingStream.typed(thumfile.openRead()));
   var lengh = await file.length();
   var thumbLength = await thumfile.length();
   var uri = Uri.parse(uploading_url);
   var thumburi = Uri.parse(thumb_uploading_url);
   var request = http.MultipartRequest("POST",uri);
   var thumbRequest = http.MultipartRequest("POST",thumburi);
   var multifile = http.MultipartFile("videos",stream,lengh,filename: basename(file.path));
   var thumbmultifile = http.MultipartFile("thumbs",thumbstream,thumbLength,filename: basename(file.path+".png"));

   request.files.add(multifile);
   thumbRequest.files.add(thumbmultifile);

   var response = await request.send();
   var thumbResponse = await thumbRequest.send();

    if(thumbResponse.statusCode==200){

      Fluttertoast.showToast(
          msg: ""+thumb,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );

    }




  http.post(url,body: {
    "title": title.text,
    "singer": singer.text,
    "cat": _selectedFruit,
    "videourl": video_files_url+basename(file.path),
    "thumburl": thumb_files_url+ basename(file.path+".png")


  });
  }




   getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState((){
        this._filePath = filePath;


      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: title,
          decoration: InputDecoration(hintText: "Enter Title",),
        ),
        TextField(
          controller: singer,
          decoration: InputDecoration(hintText: "Enter Singer Name",),
        ),
        DropdownButton(
            
            value: _selectedFruit,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem),
        
        Row(children: <Widget>[
          
          
               RaisedButton(
                child: Text('Upload'),
                onPressed: _uploadData,

              ),

            RaisedButton(
              child: Text("Video"),
              onPressed: getFilePath,),
          
        ],)



      ],),
    );
  }
}
