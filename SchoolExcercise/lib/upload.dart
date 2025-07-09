
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class Upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _choose,
                child: Text('Choose Image'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: _upload,
                child: Text('Upload Image'),
              )
            ],
          ),
          file == null
              ? Text('No Image Selected')
              : Image.file(file)
        ],
      ),
    );
  }
}

final String nodeEndPoint = 'http://13.127.33.107//upload/dhanraj/homework/api/file_upload.php';

File file;

void _choose() async {
 // file = await ImagePicker.pickImage(source: ImageSource.camera);
  file = await ImagePicker.pickImage(source: ImageSource.gallery);
}

Future<void> _upload() async {
  if (file == null) return;
  String fileName = file.path.split("/").last;
  var request = http.MultipartRequest('POST', Uri.parse(nodeEndPoint));
  int len = await file.length();

  request.files.add(
      await http.MultipartFile.fromPath(
          'images[]',
          fileName
      )
  );
/*  request.files.add(
      http.MultipartFile.fromBytes(
          'picture',
          File(fileName).readAsBytesSync(),
          filename: fileName.split("/").last
      )
  );*/
  var res = await request.send();
  print("rerror $res");



 /* if (file == null) return;
  String base64Image = base64Encode(file.readAsBytesSync());
  String fileName = file.path.split("/").last;
  print("bs64 $base64Image");

  http.post(nodeEndPoint, body: {
    "image": base64Image,
    "name": fileName,
  }).then((res) {
    print(res.statusCode);
  }).catchError((err) {
    print(err);
  });*/
}