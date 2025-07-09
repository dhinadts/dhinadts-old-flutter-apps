import 'package:flutter/material.dart';
import 'package:galubetech/main.dart';

PageController _pageViewer = new PageController();
bool avt = false;

class INtroSlides extends StatefulWidget {
  const INtroSlides({Key key}) : super(key: key);

  @override
  _INtroSlidesState createState() => _INtroSlidesState();
}

class _INtroSlidesState extends State<INtroSlides> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              pageSnapping: true,
              controller: _pageViewer,
              itemCount: slidesAvail.length,
              allowImplicitScrolling: true,
              itemBuilder: (context, i) {
                return Stack(children: [
                  slidesAvail[i] == null
                      ? Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                        )
                      : Image.asset(slidesAvail[i]),
                  Positioned(
                      bottom: 100, left:50.0,
                      child: Container(
                        width:  MediaQuery.of(context).size.width-100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              dataStrings[i],
                              maxLines: 5,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                      )),
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
                              _pageViewer.animateToPage(i.floor() - 1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear);

                            },
                            child: Text("Previous",
                                style: TextStyle(
                                    color: i == 0 ? Colors.white : Colors.black,
                                    decoration: TextDecoration.none,
                                    fontFamily: "Nunito",
                                    fontSize: 12.0)),
                          ),
                          dots(i + 1 == 1 ? true : false),
                          dots(i + 1 == 2 ? true : false),
                          dots(i + 1 == 3 ? true : false),
                          dots(i + 1 == 4 ? true : false),

                          i < 3
                              ? GestureDetector(
                                  onTap: () async {
                                    _pageViewer.animateToPage(i.floor() + 1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                    // _pageViewer.jumpToPage((i.floor() + 1));
                                  },
                                  child: Text("Next",
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          decoration: TextDecoration.none,
                                          fontSize: 12.0)))
                              : GestureDetector(
                                  onTap: () async {
                                    print("object");
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePageEx()));
                                  },
                                  child: Text("Start",
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          decoration: TextDecoration.none,
                                          fontSize: 12.0))),
                        ],
                      )),
                ]);
              }),
        ));
  }
}

var slidesAvail = [
  "assets/slides/slider1.png",
  "assets/slides/slider2.png",
  "assets/slides/slider3.png",
  "assets/slides/slider4.png",
];
var dataStrings = [
  "Track Your Shipments: with the Mobile App, you can now easily monitor, update and control your customer's shipments status on the Go.",
  "Know The Pending Payments: The BridgeGapp is designed to help the Management know the current financial Liabilities of their vendors and supplier without going back to the accountant.",
  "Keep track of Your Customers: Your customer won't be left behind, with the BridgeGapp, you're enjoying the freedom to take care of your customers with instant financial and operational status.",
  "Shipment Status & Document Control: Time to stop multiple sharing medium to update the shipment status. BridgeGapp Allow you to update the shipments situation every time you have an update, the same is reflected in the system and to the client.",
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
