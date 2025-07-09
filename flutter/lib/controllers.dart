// functions alone 
// db query + global declarations

import 'package:dhina/db/dbhelper.dart';
List<Map<String, dynamic>> iyal_S;
List<Map<String, dynamic>> adhikaram_S;

iyalTamil(String s) async {
  var db = DatabaseHelper();
  iyal_S = await db.any_query(
      'SELECT DISTINCT iyal_tamil from complete1 WHERE pal_tamil="$s"',
      'modi_kural_comp.db');
  // List.generate(iyal_S.length, (i) {
  //   Iyal(
  //     iyal_tamil: iyal_S[i]['iyal_tamil'],
  //   );
  // });
  
  print(iyal_S.length);
  print(iyal_S);


  // Items I = new Items();
  // I = result as Items;
  // print(I.pal_tamil[0]);
}
// List<Map<String, dynamic>> adhikaram_S;

athikaramKural(String s) async {
  var db = DatabaseHelper();
  adhikaram_S = await db.any_query(
      'SELECT DISTINCT adhikarm_tamil from complete1 WHERE iyal_tamil="$s"',
      'modi_kural_comp.db');
  // List.generate(iyal_S.length, (i) {
  //   Iyal(
  //     iyal_tamil: iyal_S[i]['iyal_tamil'],
  //   );
  // });
  
  print(adhikaram_S.length);
  print(adhikaram_S);

}
