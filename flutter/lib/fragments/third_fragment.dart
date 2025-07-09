// import 'package:dhina/db/kuralDb.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
//   List<Category> list = new List();
//   var db = new DatabaseHelper();
//   // var utility_basic = Utility_Basic();
//   // var shared_preference = Shared_Preference();
//   bool selectall = false;

//   @override
//   void initState() {
//     cat();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//   return new Scaffold(
//       appBar: new AppBar(
//         // here we display the title corresponding to the fragment
//         // you can instead choose to have a static title
//         title: new Text('Thirukkural'),
//         actions: <Widget>[
//           new Text()
// //           new GestureDetector(
// // onTap: () {
// //                     return Share.share("Text");
// //                   },
// //                   child: Text("share"),
// //           ),

// //           Text("Noti")
//         ],
//         // title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
//       ),
      
//       body: _getDrawerItemWidget(_selectedDrawerIndex),
//     );
//   }
  
//   }
  

//   Future<List<Category>> cat() async {
//     List<Map> list1 = await db.any_query(
//                 'select DISTINCT pal_tamil from complete1', "modi_kural_comp.db");
//     int len = list1.length - 1;
//     for (int i = 0; i <= len; i++) {
//       // int set_cat_id = list1[i]['cat_id'];
//       String set_category = list1[i]['pal_tamil'];

//       list.add(new Category(
//         // cat_id: set_cat_id,
//         pal_tamil: pal_tamil,
//         check: false,
//       ));
//     }
//     List<Map> count;
// /*


//    // count = db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in (" + ii + ") and checking =5", "sample.db");
//     for (int i = 0; i <= len; i++) {

//  */
// /*list.add(new Category(

//         getcount: db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in ($i) and checking =5", "sample.db"),

//       ));*//*



//       List<Map> list2= await db.any_query("SELECT cat_id from tamil_quiz WHERE cat_id in ($i) and checking =5", "sample.db");

//       int catid=list2[i]['cat_id'];


//       print(" Raa q $i , $catid , ${list2[i].length}");
//     }

// */

//     setState(() {
//       list.map((Category product) {
//         Cat_list_design(product);
//       }).toList();
//     });
//   }
// }
