// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // void main() {
// //   runApp(new MaterialApp(
// //     home: new HomePage()
// //   ));
// // }

// class HomePage1 extends StatefulWidget {
//   @override
//   HomePageState1 createState() => new HomePageState1();
// }

// class HomePageState1 extends State<HomePage1> {

//   List data;

//   Future<String> getData() async {
//     var response = await http.get(
//       Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
//       headers: {
//         "Accept": "application/json"
//       }
//     );

//     this.setState(() {
//       data = json.decode(response.body);
//     });
    
//     print(data[1]["title"]);
    
//     return "Success!";
//   }

//   @override
//   void initState(){
//     this.getData();
//   }

//   @override
//   Widget build(BuildContext context){
//     return new Scaffold(
//       appBar: new AppBar(title: new Text("Listviews"), backgroundColor: Colors.blue),
//       body: new ListView.builder(
//         itemCount: data == null ? 0 : data.length,
//         itemBuilder: (BuildContext context, int index){
//           return new Card(
//             child: new Text(data[index]["title"]),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert'; //to convert json to maps and vice versa
import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file

// void main() {
//   runApp(new MaterialApp(
//     home: new Home(),
//   ));
// }

class Home1 extends StatefulWidget {
  @override
  State createState() => new HomeState1();
}

class HomeState1 extends State<Home1> {

  TextEditingController keyInputController = new TextEditingController();
  TextEditingController valueInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "complete1.json";
  bool fileExists = false;
  Map<String, String> fileContent; 

  @override
  void initState() {
    super.initState();
    /*to store files temporary we use getTemporaryDirectory() but we need
    permanent storage so we use getApplicationDocumentsDirectory() */
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  @override
  void dispose() {
    keyInputController.dispose();
    valueInputController.dispose();
    super.dispose();
  }

  void createFile(Map<String, String> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    print("Writing to file!");
    Map<String, String> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, String> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("json Tutorial"),),
      body: new Column(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("File content: ", style: new TextStyle(fontWeight: FontWeight.bold),),
          new Text(fileContent.toString()),
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Add to json file: "),
          new TextField(
            controller: keyInputController,
          ),
          new TextField(
            controller: valueInputController,
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new RaisedButton(
            child: new Text("Add key, value pair"),
            onPressed: () => writeToFile(keyInputController.text, valueInputController.text),
          )
        ],
      ),
    );
  }
}
