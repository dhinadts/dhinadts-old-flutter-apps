import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/privacyPolicy.dart';
import 'package:launch_review/launch_review.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'main.dart';

TextStyle txtStyle1() {
  return TextStyle(
      fontFamily: "Nunito", fontSize: 25.0, fontWeight: FontWeight.w500);
}

Widget cards(BuildContext context, String title, String number, String date) {
  return /* Container(
      decoration: new BoxDecoration(
          color: Color(0xfff2f2f2), borderRadius: BorderRadius.circular(10)), */
      Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //  color: Color(0xfff2f2f2),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("$number",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito")),
                SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("$title",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito",
                        fontSize: 18.0)),
                SizedBox(),
                Text(
                  "$date",
                  style: TextStyle(fontFamily: "Nunito"),
                ),
              ],
            )
          ],
        ),
      ));
}

Widget progressBars(
    BuildContext context, String title, String cost, double percentage) {
  return Column(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width - 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$title",
              style: TextStyle(fontFamily: "Nunito"),
            ),
            Text(
              "$cost",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: "Nunito"),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 32,
            child: LinearPercentIndicator(
              linearStrokeCap: LinearStrokeCap.values[2],
              lineHeight: 20.0,
              percent: (double.tryParse(percentage.toString()) / 100),
              backgroundColor: Color(0xfff2f2f2),
              progressColor: Color(0xff1a73e8),
              animationDuration: 2000,
              animation: true,
            ),
          ),
          Positioned(
            /*  left: ((3.1 *
                                        double.tryParse(invoiceSummary[
                                                "YearlyIncomePercentage"]
                                            .toString())) +
                                    ((double.tryParse(invoiceSummary[
                                                    "YearlyIncomePercentage"]
                                                .toString()) /
                                            100) *
                                        10)), */
            left: ((3.0 *
                    double.tryParse(
                        invoiceSummary["YearlyIncomePercentage"].toString())) +
                8),
            top: 5.5,
            child: Center(
              child:
                  CircleAvatar(maxRadius: 4.0, backgroundColor: Colors.white),
            ),
          ),
        ]),
      ),
    ],
  );
}

Widget progressBarsVertical(
  BuildContext context,
  String title,
  int count,
) {
  return Container(
    width: 80.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 100.0,
          child: RotatedBox(
            quarterTurns: 3,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                LinearPercentIndicator(
                  width: 100.0,
                  lineHeight: 40.0,
                  percent: (double.tryParse(count.toString()) / 350),
                  backgroundColor: Color(0xfff2f2f2),
                  progressColor: Color(0xff1a73e8),
                  animationDuration: 2000,
                  animation: true,
                ),
                /*  count == 0 ? SizedBox() :Positioned(
                  left:  count == 350 ?   ((10.0 * (double.tryParse(count.toString()))*10/350) - 10)  : ((10.0 * (double.tryParse(count.toString()))*10/350) + 10),
                  top: 13,
                  child: Center(
                    child: CircleAvatar(
                        maxRadius: 6.0, backgroundColor: Colors.white),
                  ),
                ), */
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            "$count",
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Nunito"),
          ),
        ),
        Text(
          "$title",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ],
    ),
  );
}

class EXample extends StatefulWidget {
  const EXample({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    throw ExampleState();
  }
}

class ExampleState extends State<EXample> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

final myTween = Tween<Offset>(
  begin: const Offset(0, 0.0),
  end: Offset(1.0, 1.0),
);
FixedExtentScrollController fixedExtentScrollController =
    new FixedExtentScrollController();
bool showFab = false;
Widget searchBar(BuildContext context) {
  return showFab
      ? FloatingActionButton(
          onPressed: () {
            var bottomSheetController = showBottomSheet(
                context: context,
                builder: (context) => Container(
                      color: Colors.grey[900],
                      height: 250,
                    ));
            showFoatingActionButton(false);
            bottomSheetController.closed.then((value) {
              showFoatingActionButton(true);
            });
          },
        )
      : Container();
}

void showFoatingActionButton(bool value) {
  showFab = value;
}

Widget rowPrivacySecurity(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 25.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewPrivacyPolicy(
                          sett: 1,
                          viewLink: "https://lcsbridge.com/privacy-policy.php",
                        )));
          },
          child: Text("Privacy Policy",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: "Nunito",
              )),
        ),
        SizedBox(width: 10.0),
        InkWell(
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewPrivacyPolicy(
                          sett: 2,
                          viewLink: "https://lcsbridge.com/security.php",
                        )));
          },
          child: Text("Security",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: "Nunito",
              )),
        ),
      ],
    ),
  );
}

dialogFN(BuildContext context, var inputItems) async {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0 * MediaQuery.of(context).devicePixelRatio))),
    child: Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(children: [
        Text("Pending - ${inputItems["pending"]}"),
        Text("Completed - ${inputItems["completed"]}"),
        Text("Cancelled - ${inputItems["cancelled"]}"),
        Text("Total - ${inputItems["total"]}")
      ]),
    ),
  );
  await showDialog(
    context: context,
    builder: (BuildContext context) => errorDialog,
    barrierDismissible: true,
  );
}

TextStyle dialCard() {
  return TextStyle(
      fontFamily: "Nunito", fontSize: 20.0, fontWeight: FontWeight.bold);
}

Dio dio;
Response response;

class FunctionSSS {
  defaultFNViewUpload(BuildContext context, int id) async {
    Response response;
    Dio dio = new Dio();

    response = await dio.get(
        "http://api.lcsbridge.xyz/jobs/upload/list/$id?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
        queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domainCode,
        });

    uploadedFIles = response.data;
    secured = uploadedFIles["Secured"];
    insecured = uploadedFIles["InSecured"];
    customerFiles = uploadedFIles["Customer"];
  }
}

loginCodeFN(BuildContext context) async {
  Response response;

  Dio dio = new Dio();
  try {} catch (e) {}
  response =
      await dio.get("http://api.lcsbridge.xyz/companies", queryParameters: {
    "api_token": "$apiToken",
    "company_id": "$companyID",
    "domain": "$domainCode",
  });

  var summa = response.data;
  print(response.data.toString());

  print(summa['data']);
  // setState(() {});

  print(summa);
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0 * MediaQuery.of(context).devicePixelRatio))),
    child: Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Companies List",
                style: dialCard(),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            primary: true,
            padding: const EdgeInsets.all(10.0),
            itemCount: summa['data'].length,
            itemBuilder: (context, ii) {
              return InkWell(
                onTap: () async {
                  loginCode = summa['data'][ii]['code'];
                  companyID = summa['data'][ii]['id'];
                  companyLogo = summa['data'][ii]['logo'];

                  await prefs.setint("CompanyID", summa['data'][ii]['id']);

                  await prefs.setString("CODE", summa['data'][ii]['code']);
                  await prefs.setString(
                      "CompanyLOGO", summa['data'][ii]['logo']);

                  companyLogo = await prefs.getString("CompanyLOGO");
                  companyID = await prefs.getInt("CompanyID");
                  loginCode = await prefs.getString("CODE");
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundColor: Color(0xff1a73e8),
                            child: Text(
                              "${summa['data'][ii]['code']}",
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: "Nunito"),
                            ))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.0, //MediaQuery.of(context).size.width,
                          child: Text(
                            "${summa['data'][ii]['name']}",
                            overflow: TextOverflow.ellipsis,
                            style: dialCard(),
                          ),
                        ),
                        Text("${summa['data'][ii]['name']}")
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
  await showDialog(
    context: context,
    builder: (BuildContext context) => errorDialog,
    barrierDismissible: true,
  );
}

Widget rateUs(BuildContext context) {
  return ListTile(
    onTap: () async {
      Navigator.pop(context);

      LaunchReview.launch(
        androidAppId: "com.bridgelcs",
        // iOSAppId: "id1499946335"
      );
    },
    leading: Icon(Icons.feedback),
    title: Text("Rate Us",
        style: TextStyle(
            fontFamily: "Nunito",
            // fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black)),
  );
}

class ListTIle {}
