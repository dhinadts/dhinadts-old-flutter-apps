import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatelessWidget {
  final url;
  
  const MyHomePage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(url),),
    );
  }
}

class FileUpload extends StatelessWidget {
  void switchScreen(str, context) =>
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MyHomePage(url: str)
    ));
  @override
  Widget build(context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter File Upload Example')
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text("Insert the URL that will receive the Multipart POST request (including the starting http://)", style: Theme.of(context).textTheme.headline),
            TextField(
              controller: controller,
              onSubmitted: (str) => switchScreen(str, context),
            ),
            FlatButton(
              child: Text("Take me to the upload screen"),
              onPressed: () => switchScreen(controller.text, context),
            )
          ],
        ),
      )
    );
  }
}


class UploadPage extends StatefulWidget {
  UploadPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  var url1 = "http://13.127.33.107//upload/dhanraj/homework/api/file_upload.php";

  Future<String> uploadImage(filename, url1) async {
    var request = http.MultipartRequest('POST', Uri.parse(url1));
    request.files.add(await http.MultipartFile.fromPath('images', filename));
    var res = await request.send();
    print(res);
    print(request);
    return res.reasonPhrase;
  }
  String state = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(state)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          var res = await uploadImage(file.path, url1);
          setState(() {
            state = res;
            print(res);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/* 
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/file_upload.php';
    body {
      images: {}
    }
 */