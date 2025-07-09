import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:dhina/fragments/first_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';
import 'package:dhina/db/sharedpref.dart';
import '../Gsearch.dart';
import 'package:dhina/db/dbhelper.dart';

var prefs = Shared_Preference();
double valueHolder = 0.0;
var db = DatabaseHelper();
var favData;
bool _isFavorited = false;
bool _isfav = false;
var favKural;
List<Map<String, dynamic>> testR;
// void main() {
//   runApp(MaterialApp(
//     title: 'Returning Data',
//     home: HomeScreen(),
//   ));
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Returning Data Demo'),
//       ),
//       body: Center(child: SelectionButton()),
//     );
//   }
// }

// class SelectionButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: () {
//         _navigateAndDisplaySelection(context);
//       },
//       child: Text('Pick an option, any option!'),
//     );
//   }

//   // A method that launches the SelectionScreen and awaits the result from
//   // Navigator.pop.
//   _navigateAndDisplaySelection(BuildContext context) async {
//     // Navigator.push returns a Future that completes after calling
//     // Navigator.pop on the Selection Screen.
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SelectionScreen()),
//     );

//     // After the Selection Screen returns a result, hide any previous snackbars
//     // and show the new result.
//     Scaffold.of(context)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(SnackBar(content: Text("$result")));
//   }
// }

// class SelectionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pick an option'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: RaisedButton(
//                 onPressed: () {
//                   // Close the screen and return "Yep!" as the result.
//                   Navigator.pop(context, 'Yep!');
//                 },
//                 child: Text('Yep!'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: RaisedButton(
//                 onPressed: () {
//                   // Close the screen and return "Nope!" as the result.
//                   Navigator.pop(context, 'Nope.');
//                 },
//                 child: Text('Nope.'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
ByteData bytes; // = await rootBundle.load('assets/valluvar.png');
List<Map<String, dynamic>> favResult;
var fav_kural;

class MyApp4 extends StatefulWidget {
  final int fontSize1;
  MyApp4({Key key, this.fontSize1}) : super(key: key);
  @override
  MyApp4State createState() => MyApp4State();
}

class MyApp4State extends State<MyApp4> {
  List data;
  PageController controller = PageController();
  var currentPageValue = 0.0;
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ui.Image image;
  bool isImageloaded = false;

  prefix0.int index1;

  @override
  void initState() {
    // Future<String> _loadAStudentAsset() async {
    //   newData = await rootBundle.loadString('assets/complete1.json');
    //   print(newData);
    // }
    // a= prefs.getInt("fontSize1") as prefix0.double;
    // a = prefs.getInt("fontSize1") as prefix0.double;
    // prefs.setInt("fontSize1", a as prefix0.int);
    // a = valueHolder.toDouble();
    //  as prefix0.double;
//     Future checkFontSize1() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     a = (prefs.getDouble('fontSize1')); // as prefix0.int;
// }
    init();
    super.initState();
    // _loadAStudentAsset();
// checkFontSize1();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page; // .toInt() as double;
        print(currentPageValue);

        // print("currenpagevalue:" + currentPageValue.toString());
        // print("page No:" + (currentPageValue + 1).toString());
      });
    });
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load('assets/valluvar.jpeg');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return new CustomPaint(
        child: Text(
            "its dhinakaran"), // Text("${newData[index]['kural_no']}: ${newData[index]['kural_tamil1']}"),
        painter: new ImageEditor(image: image),
      );
    } else {
      return new Center(child: new Text('loading'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          // primary: true,
          leading: Builder(
            builder: (BuildContext context) {
              return
                  /*   child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/complete1.json'),
                  builder: (context, snapshot) {
                    // Decode the JSON
                    var newData = json.decode(snapshot.data.toString());

               */
                  IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Scaffold.of(context).openDrawer();
                  //       Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FirstFragment()),
                  // );
                  Navigator.pop(context);
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Text('திருக்குறள்'),
          actions: <Widget>[
            new FavoriteWidget(),
            // FlutterDemo(storage: CounterStorage(),),

            /*  LikeButton(
              // size: buttonSize,
              circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.deepPurpleAccent : Colors.grey,

                  // size: buttonSize,
                );
              },
              likeCount: null, //get number or put some number
              countBuilder: (int count, bool isLiked, String text) {
                text = "Removed";
                var color = isLiked ? Colors.deepPurpleAccent : Colors.white;
                Widget result;
                if (count == 0) {
                  // print("hi touched liked");
                  result = Text(
                    "loved",
                    style: TextStyle(color: color),
                  );
                } else
                  result = Text(
                    "Removed",
                    style: TextStyle(color: color),
                  );
                return result;
              },
              // onTap: (bool isLiked) {
              //    if(isLiked) {
              //    print("hi touched liked");
              //    }
              //    else  {
              //      print("hi touched unliked");
              //      isLiked = !isLiked;
              //    }
              //  },
              //   if (count == 0) {
              //     print("hi touched liked");
              //     result = Text(
              //       "loved",
              //       style: TextStyle(color: color),
              //     );
              //   } else
              //     result = Text(
              //       "Removed",
              //       style: TextStyle(color: color),
              //     );
              //   return result;
              // },
            ),
*/
            // IconButton(
            //   icon: const Icon(Icons.favorite),
            //   onPressed: () {
            //     print("object");
            //   },
            // ),

            IconButton(
              icon: const Icon(Icons.text_format),
              onPressed: () async {
                print("Text Font Size increasing");
                //var index = 12;
                // fontSize1 = await prefs.getInt("fontSize1");
                // print("fontsize : $fontSize1");
// Navigator.of(context).push(
//                   MaterialPageRoute<Null>(builder: (BuildContext context) {
//                 return new MyAppSeek(); }));
// var _fontSize;
/*
                return showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                          title: Text("Font Size"),
                          content: new // MyAppSeek(),
                          
                          Slider(
                            value: valueHolder, //.toDouble(),
                            min: 0.0,
                            max: 10.0,
                            divisions: 2,
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            label: '${valueHolder.round()}',
                            onChanged: (double newValue) {
                              setState(() {
                                valueHolder = newValue; // as prefix0.double;
                                print("Changed newValue: ${newValue.round()}");
                                //print(fontSize1);
                              });
                            },
                          ), 
                          actions: <Widget>[
                            RaisedButton(
                              color: Color(100000),
                              child: Text(
                                "Done",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                //    a = a+2 ;
                                // a = valueHolder as prefix0.double;
                                // Navigator.of(context).pop();
                                //  prefs.setdouble("fontSize1", valueHolder);
                                 
                //                 Navigator.of(context).push(
                //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                //   return new MyApp44(value: 0, fontSize1: valueHolder,);
                // }));
                                
                                
                                //               Navigator.pop(context); //, a);
                              },
                            )
                          ],
                        )); */
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // openPage(context);
                // return new MyApp2();
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new GlobalSearch();
                }));
                print("searching");
              },
            ),
          ],
        ),
        body: SafeArea(
          bottom: true,
          top: true,
          left: false,
          right: true,
//          child: new SingleChildScrollView(
          child: Container(
            child: Center(
              // Use future builder and DefaultAssetBundle to load the local JSON file
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/complete1.json'),
                  builder: (context, snapshot) {
                    // Decode the JSON
                    var newData = json.decode(snapshot.data.toString());

                    return PageView.builder(
                      // Build the ListView
                      itemCount: 1330,
                      controller: controller,
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int index) {
                        prefix0.print("OnPageChanegd:: index:: $index");
                        summa((index).round() + 1);
                        prefix0.print("rounded Index: ${index.round()}");
                        // summa(index+3);summa(index+4);summa(index+5);summa(index+6);summa(index+7);
                        // summa(index-3);summa(index-4);summa(index-5);summa(index-6);summa(index-7);
                        summa(index.round());
                      },
                      itemBuilder: (BuildContext context, int index) {
                        // setState(() {
                        //   index1 = index;
                        // });
                        cursor = index;
                        prefs.setint("cursor", cursor);
                        favKural = index + 1;
                        prefix0.print(favKural);
                        // _isFavorited = 0;
                        prefix0.print("${newData[index]['kural_tamil1']}");
                        summa(index.round() + 2);

                        prefix0.print("rounded Index: ${index.round()}");
                        prefix0.print("_isFavorited:: $_isFavorited");

                        // prefs.setint("cursor", cursor);
                        // prefs.setint("fav_kural", newData[index]['kural_no']);
                        // fav_kural = newData[index]['kural_no'];

                        // shared_preference.setint(cursor, index);

                        return Card(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "குறள்: ${newData[index]['kural_no']}", //${newData.kural_no}",
                                      style: TextStyle(fontSize: (18 + a)),
                                    ),
                                    IconButton(
                                        icon: (_isFavorited == true &&
                                                _isfav == true
                                            ? Icon(Icons.star)
                                            : Icon(Icons.star_border)),
                                        color: Colors.red[500],
                                        onPressed: () async {
                                          var favTest = (index + 1);
                                          // prefix0.print("favTest:  $favTest");
                                          testR = await db.any_query(
                                              // "SELECT * from complete where isfav = 0 and kural_no =$favKural",
                                              "SELECT * from complete where kural_no = $favTest",
                                              "modi_kural_comp.db");
                                          prefix0.print("testR: $testR");
                                          if (testR.isEmpty) {
                                            //testR.contains((index+1)) ) {
                                            setState(() {
                                              _isFavorited = true;
                                              _isfav = true;
                                              db.any_query(
                                                  //"UPDATE complete1 SET isfav=0 WHERE kural_no = $favKural",
                                                  "insert into complete select * from complete1 where kural_no = ($index+1)",
                                                  "modi_kural_comp.db");
                                              prefix0.print(
                                                  "_isFavorited00 : $_isFavorited");
                                            });
                                          } else {
                                            setState(() {
                                              _isFavorited = false;
                                              _isfav = false;
                                              db.any_query(
                                                  // "UPDATE complete1 SET isfav=1 WHERE kural_no = $favKural",
                                                  "delete from complete where kural_no = $favTest",
                                                  "modi_kural_comp.db");
                                              prefix0.print(
                                                  "_isFavorited 000 : $_isFavorited");
                                            });
                                          }
                                          // _isFavorited = 1;

                                          // db.any_query(
                                          //     "insert into complete select * from complete1 where kural_no = $favKural",
                                          //     "modi_kural_comp.db");
                                        }),
                                    new IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        // openPage(context);
                                        // return new MyApp2();
                                        // print("searching");
                                        // currentPageValue=100;
                                        // controller.jumpTo(100.0);
                                        // var a = 1330;
                                        // controller.jumpToPage(a);
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              prefix0.num _value;
                                              return AlertDialog(
                                                title: Text(
                                                    'குறள் எண்ணை தட்டவும்'),
                                                content: TextFormField(
                                                  keyboardType: TextInputType
                                                      .number, //numberWithOptions(decimal: true),
                                                  controller:
                                                      _textFieldController,
                                                  decoration: InputDecoration(
                                                      hintText: "குறள் எண்: "),
                                                  onSaved: (input) => _value =
                                                      int.tryParse(input),
                                                  // textInputAction: controller.jumpTo(value),
                                                ),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text('இல்லை'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  new FlatButton(
                                                    child: new Text('ஆம்'),
                                                    onPressed: () {
                                                      // Navigator.of(context).pop();
                                                      // print("text.controller:  ${_textFieldController.text}");
                                                      // var abcd = (_textFieldController.text).toString() ;
                                                      // print("abcd " + abcd);
                                                      // int.parse(abcd);

                                                      // controller.jumpToPage(
                                                      //     int.parse(abcd));
                                                      // Navigator.of(context)
                                                      //     .pop();
                                                      print(
                                                          "text.controller:  ${_textFieldController.text}");
                                                      var abcd =
                                                          (_textFieldController
                                                                  .text)
                                                              .toString();
                                                      print("abcd " + abcd);
                                                      var ff =
                                                          int.parse(abcd) - 1;

                                                      controller.jumpToPage(ff);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                        // _displayDialog(context);
                                        // return index=100;
                                      },
                                    ),
                                    new IconButton(
                                      icon: const Icon(Icons.content_copy),
                                      onPressed: () {
                                        // openPage(context);
                                        // return new MyApp2();
                                        print("Copied to Clipboard");
                                        ClipboardManager.copyToClipBoard(
                                                //  "குறள் எண்: ")
                                                "குறள்: ${newData[index]['kural_tamil1']} விளக்கம்: ${newData[index]['kuralvilakam_tamil']} கலைஞர் உரை: ${newData[index]['desc1']} சாலமன் பாப்பைய்யா: ${newData[index]['desc2']}")
                                            .then((result) {
                                          final snackBar = SnackBar(
                                            content:
                                                Text('Copied to Clipboard'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () {
                                                print("Copied");
                                              },
                                            ),
                                          );
                                          Scaffold.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      },
                                    ),
                                    new IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: () async {
                                        // String BASE64_IMAGE =
                                        //     "data:assets/png;base64, ...";
                                        // AdvancedShare.generic(
                                        //         msg: "Base64 file share",
                                        //         subject: "Flutter",
                                        //         title: "Share Image",
                                        //         url: BASE64_IMAGE)
                                        //     .then((response) {
                                        //   print(response);
                                        // });
                                        // Share.text('my text title', 'This is my text to share with other applications.', 'text/plain');
                                        final ByteData bytes = await rootBundle
                                            .load('assets/valluvar.png');
                                        await Share.file(
                                            'esys image',
                                            'esys.png',
                                            bytes.buffer.asUint8List(),
                                            'image/png',
                                            text:
                                                'குறள் ${newData[index]['kural_no']}: ${newData[index]['kural_tamil1']} ');
// var abcd = ImageEditor(image: image);
// if (this.isImageloaded) {
//       return new CustomPaint(
//         child: Text("${newData[index]['kural_no']}: ${newData[index]['kural_tamil1']}"),
//           painter: new ImageEditor(image: image),
//         );
//     } else {
//       return new Center(child: new Text('loading'));
//     }

                                        //ui.PictureRecorder recorder = ui.PictureRecorder();

// await Share.file('esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png', text: 'குறள் ${newData[index]['kural_no']}: ${newData[index]['kural_tamil1']} ');

                                        // Share.share(
                                        //     'App Link... www.nithra.mobi');
                                        // print("searching");
                                      },
                                    ),
                                    new IconButton(
                                      icon: const Icon(Icons.help),
                                      onPressed: () {
                                        // openPage(context);
                                        // return new MyApp2();
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       new AlertDialog(
                                        //           title: Text("Help"),
                                        //           // actions: <Widget>[
                                        //           //   ListTile(
                                        //           //     title: Text(
                                        //           //         "${newData[index]['iyal_tamil']}"),
                                        //           //     subtitle: Text(
                                        //           //         "${newData[index]['iyal_tamil']}"),
                                        //           //   )
                                        //           // ]
                                        //           );
                                        //       print("searching");
                                        //     });
                                        Alert(
                                          context: context,
                                          title: "உதவி",
                                          desc:
                                              "பால்: ${newData[index]['pal_tamil']}   இயல்: ${newData[index]['iyal_tamil']}  அதிகாரம்: ${newData[index]['adhikarm_tamil']}",
                                          // image: Image.asset(
                                          //     "assets/valluvar.png"),
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "சரி",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              color: Color.fromRGBO(
                                                  0, 179, 134, 1.0),
                                              radius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                          ],
                                        ).show();
                                        // var alertStyle = AlertStyle(
                                        //   animationType: AnimationType.fromTop,
                                        //   isCloseButton: false,
                                        //   isOverlayTapDismiss: false,
                                        //   descStyle: TextStyle(
                                        //       fontWeight: FontWeight.bold),
                                        //   animationDuration:
                                        //       Duration(milliseconds: 400),
                                        //   alertBorder: RoundedRectangleBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(0.0),
                                        //     side: BorderSide(
                                        //       color: Colors.grey,
                                        //     ),
                                        //   ),
                                        //   titleStyle: TextStyle(
                                        //     color: Colors.red,
                                        //   ),
                                        // );
                                        // Alert(
                                        //   context: context,
                                        //   style: alertStyle,
                                        //   type: AlertType.info,
                                        //   title: "உதவி",

                                        //   desc:
                                        //       "பால்: ${newData[index]['pal_tamil']}   இயல்: ${newData[index]['iyal_tamil']}  அதிகாரம்: ${newData[index]['adhikarm_tamil']}",
                                        //       image: Image.asset("assets/valluvar.png"),
                                        //   // buttons: [
                                        //   //   DialogButton(
                                        //   //     child: Text(
                                        //   //       "சரி",
                                        //   //       style: TextStyle(
                                        //   //           color: Colors.white,
                                        //   //           fontSize: 20),
                                        //   //     ),
                                        //   //     onPressed: () =>
                                        //   //         Navigator.pop(context),
                                        //   //     color: Color.fromRGBO(
                                        //   //         0, 179, 134, 1.0),
                                        //   //     radius:
                                        //   //         BorderRadius.circular(0.0),
                                        //   //   ),
                                        //   // ],
                                        // ).show();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // new Container( child: CustomScrollView( slivers: //<Widget>[
                              new Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 3.0),
                                      child: Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.white),
                                          //height: 00.0,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisSize: MainAxisSize.min,
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              // mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                //                                     Text(
                                                //                                       "குறள்:", style: TextStyle( fontSize: 20,
                                                //   color: Colors.black,
                                                //   decoration: TextDecoration.underline,
                                                //   // decorationColor: Colors.red,
                                                //   // decorationStyle: TextDecorationStyle.wavy,
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                                // ),
                                                Text(
                                                  newData[index]
                                                      ['kural_tamil1'],
                                                  style: TextStyle(
                                                    fontSize: (15 + a),
                                                    color: Colors
                                                        .deepPurpleAccent, //purple[300],
                                                    // decoration: TextDecoration.underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "விளக்கம்:",
                                                  style: TextStyle(
                                                    fontSize: 20 + a,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  newData[index]
                                                      ['kuralvilakam_tamil'],
                                                  style: TextStyle(
                                                    fontSize: 15 + a,
                                                    color: Colors.purple,
                                                    // decoration: TextDecoration.underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "கலைஞர் உரை:",
                                                  style: TextStyle(
                                                    fontSize: 20 + a,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  newData[index]['desc1'],
                                                  style: TextStyle(
                                                    fontSize: 15 + a,
                                                    color: Colors.purple,
                                                    // decoration: TextDecoration.underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "சாலமன் பாப்பைய்யா:",
                                                  style: TextStyle(
                                                    fontSize: 20 + a,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  newData[index]['desc2'],
                                                  style: TextStyle(
                                                    fontSize: 15 + a,
                                                    color: Colors.purple,
                                                    // decoration: TextDecoration.underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Kural: ${newData[index]['kural_no']}",
                                                  style: TextStyle(
                                                    fontSize: 20 + a,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    newData[index]
                                                        ['kural_thanglish1'],
                                                    style: TextStyle(
                                                      fontSize: 15 + a,
                                                      color: Colors.purple,
                                                    )),
                                                Text(
                                                    newData[index]
                                                        ['kural_thanglish2'],
                                                    style: TextStyle(
                                                      fontSize: 15 + a,
                                                      color: Colors.purple,
                                                    )),
                                                Text(
                                                  "Explanation: ",
                                                  style: TextStyle(
                                                    fontSize: 20 + a,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    // decorationColor: Colors.red,
                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  newData[index]
                                                      ['kuralvilakam_english'],
                                                  style: TextStyle(
                                                    fontSize: 15 + a,
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                                // Text("kural_no: " + newData[index]['kural_no']),
                                              ])))),
                              // Text("adhikarm_no " + newData[index]['adhikarm_no']),

                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      // openPage(context);
                                      // return new MyApp2();
                                      //controller.jumpTo(currentPageValue-1.0);
                                      controller.jumpToPage(
                                          currentPageValue.floor() - 1);
                                      print("searching");
                                    },
                                  ),
                                  OutlineButton(
                                    child: Text(
                                        "${newData[index]['kural_no']}/1330"),
                                    onPressed: null,
                                    textColor: Colors.blue,
                                    // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                                    //borderSide: BorderSide(color: Colors.yellow),
                                    borderSide: BorderSide(color: Colors.blue),
                                    shape: StadiumBorder(),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      // openPage(context);
                                      // return new MyApp2();
                                      //position = currentAnimationValue.floor() + 1;
                                      controller.jumpToPage(
                                          currentPageValue.floor() + 1);
                                      //print("searching");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      // itemCount: new_data == null ? 0 : new_data.length,
                    );
                  }),
            ),
          ),
        ));
  }

  summa(int value) async {
    List<Map<String, dynamic>> result10; // = null;
    List<Map<String, dynamic>> result09; // = null;
    var result9;
    List<Map<String, dynamic>> result11; // = null;
    // int temp = await prefs.getInt("cursor");
    try {
      result10 =
          await db.any_query("select * from complete", "modi_kural_comp.db");
      if (result10.isEmpty) {
        _isFavorited = false;
        _isfav = false;
      } else if (result10.isNotEmpty) {
        result09 = await db.any_query(
            "select kural_no from complete", "modi_kural_comp.db");
        for (var i = 0; i < result09.length; i++) {
          prefix0.print("Try Catch: ${result09[i]['kural_no']}");
          await db.any_query(
              "UPDATE complete1 SET isfav=1 WHERE kural_no = ${result09[i]['kural_no']}",
              "modi_kural_comp.db");
          // controller.addListener(() {
          //   setState(() {
          //     if(currentPageValue == result09[i]['kural_no'])
          //     _isFavorited = true;
          //   });
          // });
        }
      } else {
        prefix0.print("Not Happening");
      }
    } catch (e) {
      prefix0
          .print("Exception result10: Complete Table   true  " + e.toString());
    }

    try {
      result11 = await db.any_query(
          "SELECT * from complete where kural_no =$value ",
          "modi_kural_comp.db");
      prefix0.print("Summa : result11: $result11");
      if (result11.isEmpty) {
        _isFavorited = false;
        _isfav = false;
      } else {
        _isFavorited = true;
        _isfav = true;
      }
      // prefix0.print("result11: ${result11[0]['kural_tamil1']}");
    } catch (Exception) {
      prefix0.print("Exception result11:   true  " + Exception.toString());
    }
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          prefix0.num _value;
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextFormField(
              keyboardType:
                  TextInputType.number, //numberWithOptions(decimal: true),
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Type Kural Number"),
              onSaved: (input) => _value = num.tryParse(input),
              // textInputAction: controller.jumpTo(value),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('GO'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  print(_textFieldController.text);
                  // double number = (_textFieldController.text) as double;
                  // print(number);
                  _value = /*double.parse */ (_textFieldController
                      .text) as prefix0.double;
                  var a = _value.toInt();
                  prefix0.print("a : $a");
                  prefix0.print("value: $_value"); // as prefix0.int;;
                  controller.jumpToPage(a);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  //  void _helpDialog() {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("${newData[index]['iyal_tamil']}"),
  //         content: new Text("${newData[index]['iyal_tamil']}"),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

class ImageEditor extends CustomPainter {
  ImageEditor({
    this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    Future<ByteData> bytes = image.toByteData();
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
// #enddocregion FavoriteWidget

// #docregion _FavoriteWidgetState, _FavoriteWidgetState-fields, _FavoriteWidgetState-build
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // #enddocregion _FavoriteWidgetState-build
  bool _isFavorited = true;
  var fav;

  // int _favoriteCount = 41;
  // #enddocregion _FavoriteWidgetState-fields

  // #docregion _toggleFavorite
  void _toggleFavorite() async {
    setState(() async {
      if (_isFavorited) {
        // _favoriteCount -= 1;
        _isFavorited = false;
        prefix0.print("Not DB calling");
        //   fav = await prefs.getInt("fav_kural");
        //   print(fav);
        // await  db.any_query(
        // 'CREATE TABLE complete(id INT, pal_tamil TEXT, iyal_tamil TEXT, adhikarm_no INT, adhikarm_tamil TEXT, kural_no INT, kuralvilakam_tamil TEXT, kural_tamil1 TEXT, isfav INT, "Kural_no:1", desc1 TEXT, desc2 TEXT)', 'modi_kural_comp.db');

        await db.any_query(
            'INSERT into complete SELECT * from complete1 where kural_no = $fav_kural',
            'modi_kural_comp.db');
        //  fav_result = await db.any_query(
        //      'SELECT * from favourites',
        //  'modi_kural_comp.db');
        //  print("Added Favourite $fav_result");

      } else {
        // _favoriteCount += 1;
        _isFavorited = true;
        //   var i;
        //  i = await  db.any_query(
        //      'SELECT * from complete',
        // // complete1 where kural_no = 2',
        //   'modi_kural_comp.db');
        print("DB::: complete1");
        favResult = await db.any_query(
            //  SELECT * from complete ORDER BY kural_no ASC
            'select * from complete ',
            'modi_kural_comp.db');
        // // for ( i = 0; i < favResult.length; i++)
        // print("Added Favourite $favResult");
      }
    });
  }
  // #enddocregion _toggleFavorite

  // #docregion _FavoriteWidgetState-build
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        // SizedBox(
        //   width: 18,
        //   child: Container(
        //     child: Text('$_favoriteCount'),
        //   ),
        // ),
      ],
    );
  }
  // #docregion _FavoriteWidgetState-fields
}
