// import 'package:flutter/material.dart';

// import 'package:qr_code_scanner/qr_code_scanner.dart';


// class QrCodeAttendance extends StatefulWidget {
//   QrCodeAttendance({Key key}) : super(key: key);

//   @override
//   _QrCodeAttendanceState createState() => _QrCodeAttendanceState();
// }

// class _QrCodeAttendanceState extends State<QrCodeAttendance> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   var qrText = "";
//   QRViewController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text('Scan result: $qrText'),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData;
        
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }