import 'package:http/http.dart' as http;

import 'imports.dart';

//var url = 'http://192.168.57.155:3000/addfeedback';


class Post {
  final String type = "Dictionary_ios";
  final String vcode = "$versionCode";
  final String email;
  final String feedback;
  final String model="$device_name";

  Post({type, vcode, model, this.email, this.feedback});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      type: json['type'],
      vcode: json['vcode'],
      email: json['email'],
      feedback: json['feedback'],
      model: json['model'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["vcode"] = vcode;
    map["email"] = email;
    map["feedback"] = feedback;
    map["model"] = model;
    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    } else {
      print(Post.fromJson(json.decode(response.body)));
      return Post.fromJson(json.decode(response.body));
    }
  });
}


class ServerUtilities{

  final String regId="$fcm_token";
  final String email="$deviceid";
  final String vcode = "$versionCode";
  final String vname="$versionName";



  ServerUtilities({ regId,  Emailid,  vername,  vercode});




/*
  postDataParams.put("email", Emailid);
  postDataParams.put("regId", regId);
  postDataParams.put("vname", vername);
  postDataParams.put("vcode", vercode + "");
  postDataParams.put("andver", Build.VERSION.RELEASE);
  postDataParams.put("sw", "" + context.getResources().getString(R.string.screen_identification));
  postDataParams.put("asw", sharedPreference.getString(context, "smallestWidth"));
  postDataParams.put("w", sharedPreference.getString(context, "widthPixels"));
  postDataParams.put("h", sharedPreference.getString(context, "heightPixels"));
  postDataParams.put("d", sharedPreference.getString(context, "density"));*/

  factory ServerUtilities.fromJson(Map<String, dynamic> json) {
    return ServerUtilities(
      Emailid: json['email'],
      regId: json['regId'],
      vername: json['vname'],
      vercode: json['vcode'],
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["regId"] = regId;
    map["email"] = email;
    map["vname"] = vname;
    map["vcode"] = vcode;
    /*map["andver"] = andver;
    map["sw"] = sw;
    map["h"] = h;
    map["w"] = w;
    map["d"] = d;*/
    return map;
  }


}
