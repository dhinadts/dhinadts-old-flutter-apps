// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DateTimePicker extends StatelessWidget {
//   const DateTimePicker(
//       {Key key,
//       this.labelText,
//       this.selectedDate,
//       this.selectedTime,
//       this.selectDate,
//       this.selectTime})
//       : super(key: key);

//   final String labelText;
//   final DateTime selectedDate;
//   final TimeOfDay selectedTime;
//   final ValueChanged<DateTime> selectDate;
//   final ValueChanged<TimeOfDay> selectTime;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: new DateTime(1970, 8),
//         lastDate: new DateTime(2101));
//     if (picked != null && picked != selectedDate) selectDate(picked);
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay picked =
//         await showTimePicker(context: context, initialTime: selectedTime);
//     if (picked != null && picked != selectedTime) selectTime(picked);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextStyle valueStyle = Theme.of(context).textTheme.body1;
//     return new Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         new Expanded(
//           flex: 4,
//           child: new _InputDropdown(
//             labelText: labelText,
//             valueText: new DateFormat.yMMMd().format(selectedDate),
//             valueStyle: valueStyle,
//             onPressed: () {
//               _selectDate(context);
//             },
//           ),
//         ),
//         const SizedBox(width: 12.0),
//         new Expanded(
//           flex: 3,
//           child: new _InputDropdown(
//             valueText: selectedTime.format(context),
//             valueStyle: valueStyle,
//             onPressed: () {
//               _selectTime(context);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _InputDropdown extends StatelessWidget {
//   const _InputDropdown(
//       {Key key,
//       this.child,
//       this.labelText,
//       this.valueText,
//       this.valueStyle,
//       this.onPressed})
//       : super(key: key);

//   final String labelText;
//   final String valueText;
//   final TextStyle valueStyle;
//   final VoidCallback onPressed;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return new InkWell(
//       onTap: onPressed,
//       child: new InputDecorator(
//         decoration: new InputDecoration(
//           labelText: labelText,
//         ),
//         baseStyle: valueStyle,
//         child: new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             new Text(valueText, style: valueStyle),
//             new Icon(Icons.arrow_drop_down,
//                 color: Theme.of(context).brightness == Brightness.light
//                     ? Colors.grey.shade700
//                     : Colors.white70),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Flutter code sample for

// This sample shows a `DropdownButton` with a customized icon, text style,
// and underline and whose value is one of "One", "Two", "Free", or "Four".
//
// ![A screenshot of the dropdown button](https://flutter.github.io/assets-for-api-docs/assets/material/dropdown_button.png)

import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

/// This Widget is the main application widget.
class DropDown1 extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int hhdropdownValue = 1;
int mmdropdownValue = 1;
int ssdropdownValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Row(children: <Widget>[
        DropdownButton<int>(
          value: hhdropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              hhdropdownValue = newValue;
            });
          },
          items: <int>[0, 1, 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        DropdownButton<int>(
          value: mmdropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              mmdropdownValue = newValue;
            });
          },
          items: <int>[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        DropdownButton<int>(
          value: ssdropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              ssdropdownValue = newValue;
            });
          },
          items: <int>[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        ]
      ),
    );
  }
}