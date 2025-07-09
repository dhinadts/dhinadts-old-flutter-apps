// import 'package:dhina/utility/utility_basic.dart';
// import 'package:flutter/material.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';
// import 'package:dhina/db/dbhelper.dart';
// import 'package:dhina/model/Getter_setter.dart';
// import 'package:dhina/db/sharedpref.dart';

// class CategoryActivity extends StatefulWidget {
//   // ShoppingList({Key key, this.product}) : super(key: key);
// /*  List<Product> product = [
//     new Product('Eggs', false),
//   ];*/

//   // cat();

//   @override
//   _CategoryActivityState createState() {
//     return new _CategoryActivityState();
//   }
// }

// class _CategoryActivityState extends State<CategoryActivity> {
//   List<Kural> list = new List();
//   var db = new DatabaseHelper();
//   var utility_basic = Utility_Basic();
//   var shared_preference = Shared_Preference();
//   bool selectall = false;

//   @override
//   void initState() {
//     cat();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           iconTheme: IconThemeData(
//             color: Colors.black, //change your color here
//           ),
//           title: new Text(
//             "Category List",
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//         ),
//         body: new Container(
//           padding: new EdgeInsets.all(8.0),
//           child: new Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               GestureDetector(
//                 onTap: () {
//                   // setState(() {
//                   //   if (selectall == true) {
//                   //     selectall = false;
//                   //     setState(() {
//                   //       for (Kural p in list) {
//                   //         // p.check = false;
//                   //       }
//                   //     });
//                   //   } else {
//                   //     selectall = true;
//                   //     setState(() {
//                   //       for (Category p in list) {
//                   //         p.check = true;
//                   //       }
//                   //     });

//                   //   }

//                   // });
//                   print("testing Rows");
//                 },
//                 child: new Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     // new Theme(
//                     //   data: ThemeData(unselectedWidgetColor: Colors.deepOrange),
//                     //   child:
//                     //   new Checkbox(
//                     //       checkColor: Colors.white, // color of tick Mark
//                     //       activeColor: Colors.deepOrange,
//                     //       value: selectall,
//                     //       onChanged: (bool value) {
//                     //         setState(() {
//                     //           selectall = value;
//                     //           for (Kural p in list) {
//                     //             p.check = value;
//                     //           }
//                     //         });
//                     //       }),
//                     // ),
//                     Text(
//                       "All Category",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//               new Expanded(
//                   child: new ListView(
//                 padding: new EdgeInsets.symmetric(vertical: 8.0),
//                 children: list.map((Kural product) {
//                   return new Cat_list_design(product);
//                 }).toList(),
//               )),
//               GradientButton(
//                 child: Text(
//                   "Play",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 gradient: MyColorGradients.green,
//                 callback: () {
//                   String kural_no = "";
//                   for (Kural p in list) {
//                     if (2>1) {
//                       print(p.kural_no);
//                       kural_no = "$kural_no,${p.kural_no}";
//                     }
//                   }
//                   print("c  $kural_no");

//                   if (cat_id.length == 0) {
//                     utility_basic.toastfun(
//                         "குறைந்தபட்சம் ஒரு வகையைத் தேர்ந்தெடுக்கவும்..");
//                   } else {
//                     shared_preference.setString("questioncondition", cat_id);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ViewerActivity()),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<List<Category>> cat(String inp_pal) async {
    
//     List<Map> list1 = await db.any_query(
//         "SELECT DISTINCT iyal_tamil from complete1 WHERE pal_tamil=$inp_pal", "sample.db");

//     int len = list1.length - 1;
//     for (int i = 0; i <= len; i++) {
//       int set_cat_id = list1[i]['cat_id'];
//       String set_category = list1[i]['category'];

//       list.add(new Category(
//         cat_id: set_cat_id,
//         category: set_category,
//         check: false,
//       ));
//     }
//     List<Map> count;
//     /*
                  
                  
//                      // count = db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in (" + ii + ") and checking =5", "sample.db");
//                       for (int i = 0; i <= len; i++) {
                  
//                    */
//     /*list.add(new Category(
                  
//                           getcount: db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in ($i) and checking =5", "sample.db"),
                  
//                         ));*/ /*
                  
                  
                  
//                         List<Map> list2= await db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in ($i) and checking =5", "sample.db");
                  
//                         int catid=list2[i]['cat_id'];
                  
                  
//                         print(" Raa q $i , $catid , ${list2[i].length}");
//                       }
                  
//                   */

//     setState(() {
//       list.map((Category product) {
//         Cat_list_design(product);
//       }).toList();
//     });
//   }
// }


// class Cat_list_design extends StatefulWidget {
//   final Category product;

//   Cat_list_design(Category product)
//       : product = product,
//         super(key: new ObjectKey(product));

//   @override
//   Cat_list_designState createState() {
//     return new Cat_list_designState(product);
//   }
// }

// class Cat_list_designState extends State<Cat_list_design> {
//   final Category product;

//   Cat_list_designState(this.product);

//   @override
//   Widget build(BuildContext context) {
//     var ischeck = true;
//     return GradientCard(
//       gradient: MyColorGradients.orangecheckbox,
//       shape:
//           RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//       elevation: 20.0,
//       margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
//       child: new ListTile(
//           onTap: () {
//             setState(() {
//               if (product.check == true) {
//                 product.check = false;
//               } else {
//                 product.check = true;
//               }
//             });
//           },
//           title: new Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               new Expanded(
//                   child: new Text(
//                 product.category,
//                 textAlign: TextAlign.center,
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               )),
//               /* new Expanded(
//                   child: new Text(
//                 product.get_cat_id.toString(),textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white),
//               )),*/
//               Theme(
//                 data: ThemeData(unselectedWidgetColor: Colors.white),
//                 child: new Checkbox(
//                     checkColor: Colors.deepOrange, // color of tick Mark
//                     activeColor: Colors.white,
//                     value: product.check,
//                     onChanged: (bool value) {
//                       setState(() {
//                         product.check = value;

//                         /*for (CategoryActivity p in list) {
//                           if (p.check) {
//                             print(p.cat_id);
//                             cat_id = "$cat_id,${p.cat_id}";
//                           }
//                         }
// */
//                       });
//                     }),
//               ),
//             ],
//           )),
//     );
//   }

//   @override
//   void initState() {
//     // getcount();
//     super.initState();
//   }

//   /*void getcount() {
//     var db = new DatabaseHelper();
//     List<Map> count;
//     count = db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in (" + ii + ") and checking =5", "sample.db");


//   }*/

// }
