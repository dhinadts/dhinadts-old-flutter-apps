
import 'package:device_id/device_id.dart';
import 'package:get_version/get_version.dart';

import '../imports.dart';



class Utility_Basic {
  void versions() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
  }

  void toastfun(String ss) {
    Fluttertoast.showToast(
        msg: "" + ss,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        gravity: ToastGravity.BOTTOM);
  }

  void moreFun() async {
    var url = '';
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/developer?id=Nithra';
    } else {
      url = 'https://apps.apple.com/in/developer/nithra/id1442863218';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

   void rate_app() async {
     LaunchReview.launch(
         androidAppId: "nithra.tamil.quiz",
         iOSAppId: "id1484332988");

   }

  device_info() async {

    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo infoandroid = await deviceInfo.androidInfo;
      device_name = infoandroid.manufacturer + " " + infoandroid.model;

    } else {
      IosDeviceInfo infoios = await deviceInfo.iosInfo;
      device_name = infoios.utsname.machine;
      // device_version = infoios.utsname.version;
    }
  }

  checknetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  deviceID() async {
    deviceid = await DeviceId.getID;
    // print("device id$deviceid");
    return deviceid;
  }
}
