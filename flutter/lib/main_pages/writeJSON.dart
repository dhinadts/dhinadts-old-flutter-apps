import 'package:dhina/main_pages/starting2.dart';
import 'package:dhina/main_pages/starting4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert'; //to convert json to maps and vice versa
import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file



class CreateJSON extends StatefulWidget {
  @override
  State createState() => new HomeState();
}

class HomeState extends State<CreateJSON> {

  TextEditingController keyInputController = new TextEditingController();
  TextEditingController valueInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "myJSONFile.json";
  bool fileExists = false;
  Map<String, String> fileContent; 
var jsonData; 
  @override
  void initState() {
     Future<String> loadJsonData() async {
    jsonData = await rootBundle.loadString("assets/complete1.json");
    //data = jsonData; //.toList();
    print(jsonData);
  }
    super.initState();
    loadJsonData();
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
       
      jsonFileContent.addAll(favData);
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
      appBar: new AppBar(title: new Text("JSON Tutorial"),),
      body: new Column(
        children: <Widget>[
          
          new Text(fileContent.toString()),
          
          
          new TextField(
            controller: favData,
          ),
          new TextField(
            controller: favData
          ),
          
          new RaisedButton(
            child: new Text("Add key, value pair"),
            onPressed: () => writeToFile(keyInputController.text, valueInputController.text),

          ),
        //   new ListView.builder(
        // itemCount: jsonData == null ? 0 : jsonData.length,
        // itemBuilder: (BuildContext context, int index){
        //   return new Card(
        //     child: new Text(jsonData[index]["kural_no"]),
        //   );
        // }
        //   ),
        ],
      ),
    );
  }
}
