import 'package:dictionary/imports.dart';
import 'package:flutter/material.dart';



class Home_list_design extends StatefulWidget {

   var product;


  Home_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<Home_list_design> {
   var  product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(1.0),
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${product.id}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      thickness: 5.0,
                      color: Colors.black,
                    ),

                    Expanded(
                      flex: 3,
                      child: Text(
                        '${product.engword}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${product.tamilword}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
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
