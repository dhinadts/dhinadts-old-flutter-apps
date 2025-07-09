import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class AssignHomework extends StatefulWidget {
  @override
  AssignHomeworkDetails createState() {
    return new AssignHomeworkDetails();
  }
}

class AssignHomeworkDetails extends State<AssignHomework> {
  String isClassradio = "";
  int ict = 0;
  File _imageFile;
  File _imageFile2;
  bool _isUploading = false;

  String baseUrl =
      'http://13.127.33.107//upload/dhanraj/homework/api/file_upload.php';

  var birthDateInString = 'dd/mm/yy';
  DateTime birthDate; // instance of DateTime
  bool isDateSelected = false;
  String datetext = "Select date";
  var titleedit = new TextEditingController();
  var descedit = new TextEditingController();

  bool _loadingPath = false;
  bool _multiPick = false;
  String _fileName;
  String _path;
  Map<String, String> _paths;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollViewController;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Assigning Homework",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(50)),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Class",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey)),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Section",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey)),
                      ),
                    ),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () async {
                      final datePick = await showDatePicker(
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100));
                      if (datePick != null && datePick != birthDate) {
                        setState(() {
                          birthDate = datePick;
                          isDateSelected = true;

                          // put it here
                          datetext =
                              new DateFormat("dd\/MM\/yyyy").format(birthDate);
                          // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                        });
                      }
                    },
                    child: Text("$datetext")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleedit,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descedit,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Upload Files (*if any)"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    _imageFile == null
                        ? GestureDetector(
                            onTap: () {
                              _openImagePickerModal(context);
                            },
                            child: Image.asset(
                              "assets/addfile.png",
                              height: 50,
                              width: 50,
                            ))
                        : SizedBox(
                            height: ScreenUtil().setHeight(200),
                            width: ScreenUtil().setWidth(200),
                            child: Image.file(
                              _imageFile,
                              fit: BoxFit.scaleDown,
                              height: 50.0,
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                    _imageFile2 == null
                        ? GestureDetector(
                            onTap: () {
                              _openImagePickerModal(context);
                            },
                            child: Image.asset(
                              "assets/addfile.png",
                              height: 50,
                              width: 50,
                            ))
                        : SizedBox(
                            height: ScreenUtil().setHeight(200),
                            width: ScreenUtil().setWidth(200),
                            child: Image.file(
                              _imageFile2,
                              fit: BoxFit.scaleDown,
                              height: 50.0,
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                  ],
                ),
              ),
              _buildUploadBtn(),
            ],
          ),
        ),
      ),
    );
  }

  /* void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }*/
  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    setState(() {
      if (_imageFile == null) {
        _imageFile = image;
      } else {
        _imageFile2 = image;
      }
    });

    // Closes the bottom sheet
    Navigator.pop(context);
  }

  Future _uploadImage(File image, File image2) async {
    setState(() {
      _isUploading = true;
    });

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    final mimeTypeData2 =
        lookupMimeType(image2.path, headerBytes: [0xFF, 0xD8]).split('/');

    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrl));

    if (_imageFile != null) {
      final file = await http.MultipartFile.fromPath('images[]', image.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
      final file1 = await http.MultipartFile.fromPath('images[]', image2.path,
          contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));
      imageUploadRequest.files.add(file);
      imageUploadRequest.files.add(file1);
    } else {
      imageUploadRequest.fields['images[]'] = '';
    }
    //imageUploadRequest.fields['ext'] = mimeTypeData[1];

    imageUploadRequest.fields['action'] = 'assigning_homework';
    imageUploadRequest.fields['homeworkdate'] = datetext;
    imageUploadRequest.fields['classid'] = "1";
    imageUploadRequest.fields['title'] = titleedit.text;
    imageUploadRequest.fields['description'] = descedit.text;
    imageUploadRequest.fields['schoolid'] = "1";

    try {
      final streamedResponse = await imageUploadRequest.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        return null;
      } else {
        final responseData = json.decode(response.body);

        _resetState();

        return responseData;
      }
    } catch (e) {
      print("rrrr $e");
      return null;
    }
  }

  void _startUploading() async {
    var response = await _uploadImage(_imageFile, _imageFile2);
    print("response ${response[0]["status"].toString()}");

    // Check if any error occured
    if (!response[0]["status"].toString().contains("sucess")) {
      Toast.show("Image Upload Failed!!! ", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      _resetState();
    } else {
      Toast.show("Image Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
      _imageFile2 = null;
    });
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Choose',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use File Manager'),
                  onPressed: () {
                    // _openFileExplorer();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _buildUploadBtn() {
    Widget btnWidget = Container();

    if (_isUploading) {
      // File is being uploaded then show a progress indicator
      btnWidget = Container(
          margin: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator());
    } else if (!_isUploading) {
      //&& _imageFile != null
      // If image is picked by the user then show a upload btn

      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: FlatButton(
          child: Text('Send to Class'),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {
            _startUploading();
          },
          color: Color(0xFFDFFAE8),
          textColor: Color(0xFF24C38A),
        ),
      );
    }

    return btnWidget;
  }

  @override
  void initState() {
    super.initState();

    var now1 = DateTime.now();
    datetext = DateFormat("dd\/MM\/yyyy").format(now1);
  }

  Future<void> senddata() async {
    var response = await http.post(baseUrl,
        body: jsonEncode({
          'action': 'assigning_homework',
          'homeworkdate': datetext,
          'classid': 1,
          'title': titleedit.text,
          'description': descedit.text,
          'images[]': 0,
          'schoolid': 1,
        }));

    print("reeeees $response");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if (!abcd[0]["status"].toString().contains("success")) {
      Toast.show("Assigned !!! ", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    setState(() {});
  }
}
