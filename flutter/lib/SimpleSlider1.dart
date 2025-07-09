import 'package:dhina/main.dart';
import 'package:dhina/main_pages/starting4.dart';
import 'package:flutter/material.dart';

// void main() => runApp(App());

// class SimpleSlider1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SimpleSlider11(),
//     );
//   }
// }

// class SimpleSlider11 extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<SimpleSlider11> {
//   double _fontSize11 = 15.0;

//   void _showFontSizePickerDialog() async {
//     // <-- note the async keyword here

//     // this will contain the result from Navigator.pop(context, result)
//     final selectedFontSize = await showDialog<double>(
//       context: context,
//       builder: (context) => FontSizePickerDialog(initialFontSize: _fontSize11),
//     );

//     // execution of this code continues when the dialog was closed (popped)

//     // note that the result can also be null, so check it
//     // (back button or pressed outside of the dialog)
//     if (selectedFontSize != null) {
//       setState(() {
//         _fontSize11 = selectedFontSize;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text('Font Size: $_fontSize11'),
//             RaisedButton(
//               onPressed: _showFontSizePickerDialog,
//               child: Text('Select Font Size'),
//             ),
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                             _showFontSizePickerDialog();

//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// move the dialog into it's own stateful widget.
// It's completely independent from your page
// this is good practice
// double dummy = 15.0;
class FontSizePickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final double initialFontSize;

  const FontSizePickerDialog({Key key, @required this.initialFontSize})
      : super(key: key);

  @override
  _FontSizePickerDialogState createState() => _FontSizePickerDialogState();
}

class _FontSizePickerDialogState extends State<FontSizePickerDialog> {
  /// current selection of the slider
  double _fontSize12 = 0.0;

  @override
  Future initState() {
    super.initState();
    _fontSize12 = widget.initialFontSize;
    getFontSize();
  }

  getFontSize() async {
    dummy = await prefs.getDouble("FontSizeDummy");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text('எழுத்துரு அளவு'),
      content: Container(
        width: 100,
        height: 50,
        child: Slider(
          value: _fontSize12,
          min: 0,
          max: 20,
          divisions: 10,
          onChanged: (value) async {
            setState(() {
              _fontSize12 = value;
              dummy = 15 + value;
            });
            await prefs.setdouble("FontSizeDummy", dummy);
          },
        ),
      ),
      actions: <Widget>[
        Text("அளவு: $dummy "),
        FlatButton(
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _fontSize12);
          },
          child: Text('அமைக்க'),
        )
      ],
    );
  }
}
