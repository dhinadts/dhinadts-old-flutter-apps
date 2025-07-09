// // import 'package:custom_shape/curve_painter.dart';
// import 'package:flutter/material.dart';

// // import 'package:custom_shape/pages/drawing_page.dart';
// // import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Drawing Shapes",
//       home: DrawingPage(),
//     );
//   }
// }

// class DrawingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Blade Runner"),
//         ),
//         body: CustomPaint(
//           painter: CurvePainter(),
//           child: Center(
//             child: Text(
//               "Blade Runner",
//               style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
//             ),
//           ),
//         ));
//   }
// }

// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();
//     paint.color = Colors.amber;
//     paint.strokeWidth = 5;
//     canvas.drawLine(
//       Offset(0, size.height / 2),
//       Offset(size.width, size.height / 2),
//       paint,
//     );

//     paint.color = Colors.blue;
//     paint.style = PaintingStyle.stroke;
//     canvas.drawCircle(
//         Offset(size.width / 2, size.height / 2), size.width / 4, paint);

//     paint.color = Colors.green;

//     var path = Path();
//     path.moveTo(size.width / 3, size.height * 3 / 4);
//     path.lineTo(size.width / 2, size.height * 5 / 6);
//     path.lineTo(size.width * 3 / 4, size.height * 4 / 6);
//     path.close();

//     paint.style = PaintingStyle.fill;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }



import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';

// void main() => runApp(new MyApp());

class MyApp10 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ui.Image image;
  bool isImageloaded = false;
  void initState() {
    super.initState();
    init();
  }

  Future <Null> init() async {
    final ByteData data = await rootBundle.load('assets/valluvar.jpeg');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return new CustomPaint(
        child: Text("அகர முதல எழுத்தெல்லாம் ஆதி\nபகவன் முதற்றே உலகு\nExplanation: எழுத்துக்கள் எல்லாம் அகரத்தை அடிப்படையாக கொண்டிருக்கின்றன. அதுபோல உலகம் கடவுளை அடிப்படையாக கொண்டிருக்கிறது."),
          painter: new ImageEditor(image: image),
        );
    } else {
      return new Center(child: new Text('loading'));
    }
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child: _buildImage(),
      )
    );
  }
}

class ImageEditor extends CustomPainter {


  ImageEditor({
    this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    Future<ByteData> data = image.toByteData();
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}