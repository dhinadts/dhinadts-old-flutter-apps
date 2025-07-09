import 'package:animated/SplashScreenSample.dart';
import 'package:animated/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:galubetech/main.dart';

PageController _pageViewer = new PageController();
bool avt = false;

class INtroSlides extends StatefulWidget {
  const INtroSlides({Key key}) : super(key: key);

  @override
  _INtroSlidesState createState() => _INtroSlidesState();
}

class _INtroSlidesState extends State<INtroSlides> {
  int index = 0;
  @override
  void initState() {
    super.initState();
    // fn();
  }

  fn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("IntroSlides", 1);
    introSlide = prefs.getInt("IntroSlides");
    
    //  await prefs.setInt("LoggedIN", null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  pageSnapping: true,
                  controller: _pageViewer,
                  itemCount: slidesAvail.length,
                  allowImplicitScrolling: true,
                  onPageChanged: (i) {
                    setState(() {
                      index = i;
                    });
                  },
                  itemBuilder: (context, i) {
                    // index = i;
                    return Stack(children: [
                      slidesAvail[i] == null
                          ? Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height,
                            )
                          : Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
                            child: Image.asset(slidesAvail[i], fit: BoxFit.fill, ),),
                      Positioned(
                          bottom: MediaQuery.of(context).size.height>640 ? 120 : 90,
                          left: 50.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  dataStrings[i],
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Gilory-Medium",
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 22.0),
                                ),
                              ),
                            ),
                          )),
                          
                    ]);
                  }),
                   Positioned(
                  bottom: 50.0,
                  left: 25.0,
                  right: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _pageViewer.animateToPage(index.floor() - 1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Text("Previous",
                            style: TextStyle(
                                color: index == 0 ? Colors.white : Colors.black,
                                decoration: TextDecoration.none,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0)),
                      ),
                      dots(index + 1 == 1 ? true : false),
                      dots(index + 1 == 2 ? true : false),
                      dots(index + 1 == 3 ? true : false),
                      dots(index + 1 == 4 ? true : false),
                      index < 3
                          ? GestureDetector(
                              onTap: () async {
                                _pageViewer.animateToPage(index.floor() + 1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              },
                              child: Text("Next",
                                  style: TextStyle(
                                      fontFamily: "Gilory-Medium",
                                      decoration: TextDecoration.none,
                                      fontSize: 12.0)))
                          : GestureDetector(
                              onTap: () async {
                               await fn();
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SplashScreenSample()));
                              },
                              child: Text("Start",
                                  style: TextStyle(
                                      fontFamily: "Gilory-Medium",
                                      decoration: TextDecoration.none,
                                      fontSize: 12.0))),
                    ],
                  )),
            ],
          )),
    );
  }
}

var slidesAvail = [
  "assets/slides/welcome.png",
  "assets/slides/documents.png",
  "assets/slides/statement.png",
  "assets/slides/track.png",
];
var dataStrings = [
  "Welcome to Bridge Portal",
  "The new mobile window to share shipment documents.",
  "Keep your books: lets your customer access the invoices and Statements.",
  "Get live shipment status on the go on your mobile devices",
];

Widget dots(bool act) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: 8,
    width: 8,
    decoration: BoxDecoration(
      color: act ? Colors.grey[200] : Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
