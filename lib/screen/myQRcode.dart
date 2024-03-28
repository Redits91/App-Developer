import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrbox/constant/color.dart' as color;
import 'package:hrbox/retrofit.dart';

import 'dart:developer';
import 'dart:io';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class myQRcode extends StatefulWidget {
  final String id;
  final String branchName;
  final String branchID;

  const myQRcode({super.key, required this.id, required this.branchName, required this.branchID});

  @override
  State<myQRcode> createState() => _myQRcodeState();
}

class _myQRcodeState extends State<myQRcode> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String unique_qr_no = "";
  String employee_code = "";
  String employee_name = "";
  String profile_image = "";
  String department_name = "";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color.primary_color));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40,right: 10,left: 10,bottom: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  Text(widget.id == '3' ? "Canteen IN" : "Attendance", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color.black
                  ),),
                  SizedBox(height: 5,),
                  Text("Branch : ${widget.branchName}", style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: color.black
                  ),),
                  SizedBox(height: 5,),
                  Text(widget.id == '1' || widget.id == '3' ? "IN" : "OUT" , style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: color.black
                  ),),
                ],
              ),
            ),
            Expanded(flex: 4, child: _buildQrView(context)),
            Container(
              padding: EdgeInsets.only(top: 10,right: 10,left: 10),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("QRCODE", style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color.black
                  ),),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter QRCode',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: (){
      
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 15, color: color.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: color.primary_color,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {

    // For this example we check how wide or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sized after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.green,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 5,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: IconButton(
            icon: Icon(Icons.flashlight_on, size: 40,),
            onPressed: () async {
              await controller?.toggleFlash();
            },
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print("result ${result!.code}");
        scanQRforAttendanceIN(result!.code.toString());

      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: color.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3)
        ),
        title: Text('Are you sure you want to go back?', style: TextStyle(fontSize: 13),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No button
            child: Text('No', style: TextStyle(fontWeight: FontWeight.w700,color: color.black),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Yes button
            child: Text('Yes', style: TextStyle(fontWeight: FontWeight.w700,color: color.black),),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  scanQRforAttendanceIN(String result) async {
    try {
      var response = await ScanQRforAttendanceIN(result, widget.id, widget.branchID);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          controller?.pauseCamera();
          var result = extractedData['result'];
          unique_qr_no = result['unique_qr_no'];
          employee_code = result['employee_code'];
          employee_name = result['employee_name'];
          profile_image = result['profile_image'];
          department_name = result['department_name'];
          showToast(extractedData['ack_msg'], color.green);
          showPopup(context);

        } else {
          showToast(extractedData['ack_msg'], color.red);
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  void showPopup(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: InkWell(
            onTap: () {
              Navigator.pop(context);
              controller?.resumeCamera();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(profile_image),
                  Text(employee_name+"(${employee_code}))"),
                  Text("${department_name}(${unique_qr_no}")
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}





