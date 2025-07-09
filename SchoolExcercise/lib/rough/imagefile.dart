import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IMagePicker extends StatefulWidget {
  IMagePicker({Key key}) : super(key: key);

  @override
  _IMagePickerState createState() => _IMagePickerState();
}

class _IMagePickerState extends State<IMagePicker> {
  File _image;
  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _image == null
            ? Center(child: Text("NoImage"))
            : SingleChildScrollView(
                child: Column(children: [
                  Image.file(_image, height: 100, width:100),
                  profilePic(),
                ]),
              ));
  }

  Widget profilePic() {
    return Stack(children: <Widget>[
      new Image.file(_image),
      Positioned(
        left: 50.0,
        right: 50.0,
        bottom: 40.0,
        height: 64.0,

        child: RaisedButton(
          onPressed: () async {
            File image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            setState(() {
              _image = image;
            });
            print(_image.path);
             List<File> files = await FilePicker.getMultiFile(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'doc'],
        );
        print(files);
          },
          child: new Text(
            "Upload",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ), // child widget
      ),
    ]);
  }

  File profileImg;
}


