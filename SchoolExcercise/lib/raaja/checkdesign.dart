import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';


import 'studentlistmap.dart';

class Cat_list_design extends StatefulWidget {
  final Category product;

  Cat_list_design(Category product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  Cat_list_designState createState() {
    return new Cat_list_designState(product);
  }
}

class Cat_list_designState extends State<Cat_list_design> {
  final Category product;

  Cat_list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    var ischeck = true;

    /* Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              listtt[index]["profile"],
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(200),
            ),
          ),
          Expanded(
              child:
              Text('${listtt[index]["view_txt"]}')),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Checkbox(
                  value: listtt[index]["is_checked"],
                  onChanged: (value) async {}),
            ],
          )
        ],
      ),
    ),*/
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
      elevation: 20.0,
      margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
      child: new ListTile(
          onTap: () {
            setState(() {
              if (product.is_checked == true) {
                product.is_checked = false;
              } else {
                product.is_checked = true;
              }


              if (product.is_checked == true) {
                temp.add(product.studentid);
                product.set_is_checked=true;
              } else {
                temp.remove(product.studentid);
                product.set_is_checked=false;
              }
            });
          },
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.profile,
                  height: ScreenUtil().setHeight(200),
                  width: ScreenUtil().setWidth(200),
                ),
              ),
              new Expanded(
                  child: new Text(
                "${product.studentid}${product.view_txt}",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.black),
                child: new Checkbox(
                    checkColor: Colors.deepOrange, // color of tick Mark
                    activeColor: Colors.black,
                    value: product.is_checked,

                    onChanged: (bool value) {
                      setState(() {
                        if ("${product.is_checked}" == "0") {
                        } else {
                          product.is_checked = value;
                        }

                        if (product.is_checked == true) {
                          temp.add(product.studentid);
                          product.set_is_checked=true;
                        } else {
                          temp.remove(product.studentid);
                          product.set_is_checked=false;
                        }

                      });
                    }),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
