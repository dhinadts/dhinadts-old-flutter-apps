import 'package:http/http.dart' as http;
import 'imports.dart';


void feedback_dialog(BuildContext context) {
  emailController.clear();
  feedbackController.clear();

  Dialog errorDialog = Dialog(
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(13.0 * MediaQuery.of(context).devicePixelRatio))),
    //this right here
    child: Container(
      /*decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),*/
      height: ScreenUtil().setHeight(950),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.all(6.0),
            child: Text(
              'தங்கள் கருத்துக்களை இங்கே பதிவிடவும்',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.all(6.0),
              child: TextField(
                controller: emailController,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  hintText: 'PLEASE ENTER YOUR EMAIL',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.black,),
                ),
              )),
          Padding(
              padding:
                  EdgeInsets.all(6.0 * MediaQuery.of(context).devicePixelRatio),
              child: TextField(
                controller: feedbackController,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  hintText: 'PLEASE ENTER YOUR FEEDBACK',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.black,),
                ),
              )),
          Padding(
              padding:
                  EdgeInsets.all(5.0 * MediaQuery.of(context).devicePixelRatio),
              child: GestureDetector(
                  onTap: () async {
                    var net = await utility_basic.checknetwork();

                    if (net == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()),
                      );
                    } else {
                      utility_basic.toastfun("இணைய சேவையை சரிபார்க்கவும்...");
                    }
                  },
                  child: Text("*Privacy Policy"))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GradientButton(
                child: Text("Send",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                gradient: MyColorGradients.green,
                callback: () async {
                  if (feedbackController.text == '') {
                    utility_basic
                        .toastfun('உங்கள் கருத்துக்களை தட்டச்சு செய்யவும்');
                  } else {
                    var net = await utility_basic.checknetwork();

                    if (net == true) {
                      Post newPost = new Post(
                          email: emailController.text,
                          feedback: feedbackController.text);

                      var response =
                          await http.post(feedback_url, body: newPost.toMap());
                      print("rrrr $response ");

                      utility_basic.toastfun(
                          'தங்களின் கருத்துக்கள் ஏற்கப்பட்டது, நன்றி');
                    } else {
                      utility_basic.toastfun("இணைய சேவையை சரிபார்க்கவும்...");
                    }
                     Navigator.of(context).pop();

                    /* if (fromdailog == true) {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    } else {
                      Navigator.of(context).pop();
                    } */
                  }
                },
              ),
              GradientButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                gradient: MyColorGradients.cherry,
                callback: () {
                  Navigator.of(context).pop();
                  /* if (fromdailog == true) {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  } else {
                    Navigator.of(context).pop();
                  } */
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) => errorDialog,
    barrierDismissible: false,
  );
}
void firsttime_privacy_dialog(BuildContext context) {

  Dialog errorDialog = Dialog(
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0 * MediaQuery.of(context).devicePixelRatio))),
    //this right here
    child: Container(
      /*decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),*/
      height: ScreenUtil().setHeight(900),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
            EdgeInsets.all(3.0 * MediaQuery.of(context).devicePixelRatio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  height: ScreenUtil().setHeight(120),
                  width: ScreenUtil().setWidth(120),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'PRIVACY & TERMS',
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding:
            EdgeInsets.all(3.0 * MediaQuery.of(context).devicePixelRatio),
            child: SizedBox(
                width: ScreenUtil().setWidth(1000),
                child: Text("Thanks for downloading or Updating Tamil Quiz App.")),),
          Padding(
            padding:
            EdgeInsets.all(3.0 * MediaQuery
                .of(context)
                .devicePixelRatio),
            child: SizedBox(
                width: ScreenUtil().setWidth(1000),
                child: Text(
                    "By clicking privacy tab you can read our privacy policy and agree to the terms of privacy policy to continue using Tamil Quiz App.")),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GradientButton(
                increaseWidthBy: ScreenUtil().setWidth(100),
                child: Text("Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize:12.0)),
                gradient: MyColorGradients.sea_blue,
                callback: () async {
                  var net = await utility_basic.checknetwork();

                  if (net == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicy()),
                    );
                  } else {
                    utility_basic.toastfun("இணைய சேவையை சரிபார்க்கவும்...");
                  }
                },
              ),
              GradientButton(
                increaseWidthBy: ScreenUtil().setWidth(100),
                child: Text(
                  "Accept & Continue",

                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,fontSize:12.0),
                ),
                gradient: MyColorGradients.sea_blue,
                callback: () async {
                  await shared_preference.setint("first_privacy", 1);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) => errorDialog,
    barrierDismissible: false,
  );
}

void rateus_dialog(BuildContext context) {
  Dialog errorDialog = Dialog(
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(13.0 * MediaQuery.of(context).devicePixelRatio))),
    //this right here
    child: Container(
      /*decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),*/
      height: ScreenUtil().setHeight(600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.all(6.0 * MediaQuery.of(context).devicePixelRatio),
            child: SizedBox(
              width: ScreenUtil().setWidth(800),
              child: Text(
                'இந்த இலவச ஆன்ராய்டு மென்பொருள் தங்களுக்கு உபயோகமாக இருக்கிறதா?',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GradientButton(
                child: Text("ஆம்",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                gradient: MyColorGradients.green,
                callback: () {
                  Navigator.of(context).pop();

                  showRatingDialog(context);
                },
              ),
              GradientButton(
                child: Text(
                  "இல்லை",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                gradient: MyColorGradients.cherry,
                callback: () {
                  Navigator.of(context).pop();

                  feedback_dialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) => errorDialog,
    barrierDismissible: false,
  );
}


void showRatingDialog(BuildContext context) {
  Dialog errorDialog = Dialog(
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(13.0 * MediaQuery.of(context).devicePixelRatio))),
    //this right here
    child: Container(
      /*decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),*/
      height: ScreenUtil().setHeight(700),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.all(6.0 * MediaQuery.of(context).devicePixelRatio),
            child: SizedBox(
              width: ScreenUtil().setWidth(800),
              child: Text(
                'இந்த இலவச ஆன்ராய்டு மென்பொருள் மற்றவர்களுக்கும் பயன்பட எங்களுக்கு 5 நட்சத்திர குறியீடு பிளே ஸ்டோரில் வழங்க அன்புடன் கேட்டுக் கொள்கிறோம்.',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GradientButton(
                child: Text("மதிப்பிடுக",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                gradient: MyColorGradients.green,
                callback: () {
                  Navigator.of(context).pop();
                  SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop');

                  utility_basic.rate_app();
                },
              ),
              GradientButton(
                child: Text(
                  "விடுவி",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                gradient: MyColorGradients.cherry,
                callback: () {
                  Navigator.of(context).pop();
                  feedback_dialog(context,);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) => errorDialog,
    barrierDismissible: false,
  );
}
