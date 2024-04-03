import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hrbox/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import 'package:hrbox/constant/color.dart' as color;
import 'package:hrbox/screen/Dashboard.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/MyPreferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _appVersion = '';
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String deviceUniqueId = '';
  final formkey = GlobalKey<FormState>();
  MyPreferences prefeernces = new MyPreferences();
  
  @override
  void initState() {
    super.initState();
    getAppVersion();
    // Retrieve saved credentials and set them in text fields
    getSavedCredentials();
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  void getSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    if (savedUsername != null) {
      // _usernameController.text = savedUsername;
    }
    if (savedPassword != null) {
      // _passwordController.text = savedPassword;
    }
  }

  void saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
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

  void generateDeviceUniqueId() {
    Random random = Random();
    int number = random.nextInt(99999999);
    deviceUniqueId = '$number';

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String model = '';

    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo;
      deviceInfo.androidInfo.then((info) {
        androidInfo = info;
        setState(() {
          model = androidInfo.model;
          print(model);

          // Concatenate deviceUniqueId, model, and currentDateTime here
          DateTime currentTime = DateTime.now();
          String currentDateTime = DateFormat('HH:mm:ss').format(currentTime);
          deviceUniqueId += currentDateTime + model;
          print(currentDateTime + model);
        });
      });
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      // iOS device info handling if required
      IosDeviceInfo iosInfo;
      deviceInfo.iosInfo.then((info) {
        iosInfo = info;
        setState(() {
          model = iosInfo.model;
          print(model);

          // Concatenate deviceUniqueId, model, and currentDateTime here
          DateTime currentTime = DateTime.now();
          String currentDateTime = DateFormat('HH:mm:ss').format(currentTime);
          deviceUniqueId += currentDateTime + model;
        });
      });
    }
  }

  loginUser() async {
    try {
        var response = await LoginUser(_usernameController.text, _passwordController.text, deviceUniqueId);
      print(deviceUniqueId);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          showToast(extractedData['ack_msg'], color.green);
          var result;
          result=extractedData['result'];
          prefeernces.setPreferences(MyPreferences.System_user_login_id,result['id']);
          prefeernces.setPreferences(MyPreferences.System_user_login_name,result['name']);
          prefeernces.setPreferences(MyPreferences.emp_id,result['reference_id']);
          prefeernces.setPreferences(MyPreferences.emp_code,result['employee_code']);
          prefeernces.setPreferences(MyPreferences.login_user_type,result['type']);
          prefeernces.setPreferences(MyPreferences.branch_id,result['branch_id']);
          prefeernces.setPreferences(MyPreferences.selfattendance_qr_vallue,result['unique_qr_no']);
          prefeernces.setPreferences(MyPreferences.myqrcode,result['qr_code']);
          prefeernces.setPreferences(MyPreferences.working_hour,result['working_hour']);
          prefeernces.setPreferences(MyPreferences.device_token,deviceUniqueId);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
          
        } else {
          showToast(extractedData['ack_msg'], color.red);
          // Get.snackbar("Error", extractedData['ack_msg'],backgroundColor: color.red,colorText: color.white,duration: Duration(seconds: 3));
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
        showToast("Network error occurred please try again", color.red);
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color.primary_color),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Scaffold(
        backgroundColor: color.scfold_back_color,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: [
                Container(
                  color: color.primary_color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30.0),
                      Container(
                        color: color.primary_color,
                        child: Column(
                          children: [
                            SizedBox(height: 20.0),
                            Column(
                              children: [
                                SizedBox(height: 40,),
                                Image.asset(
                                  'assets/hrbox.png',
                                  width: 120.0,
                                  height: 120.0,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Please Enter\nYour Login Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 100,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.46,
                  left: 0,
                  right: 0,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    color: color.white,
                    surfaceTintColor: color.white,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Username *',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: color.gray,
                              ),
                            ),
                            TextFormField(
                              controller: _usernameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length < 3) {
                                  return 'Enter least 3 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: color.primary_color
                                  ),
                                  child: Icon(Icons.person, color: color.white),
                                ),
                                hintText: 'Enter Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Password *',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: color.gray,
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length < 3) {
                                  return 'Enter least 3 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: color.primary_color
                                  ),
                                  child: IconButton(
                                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                    color: color.white,
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                hintText: 'Enter Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: (){
                                if (formkey.currentState!.validate()) {
                                  String username = _usernameController.text.trim();
                                  String password = _passwordController.text.trim();
                                  // Save credentials
                                  saveCredentials(username, password);
                                  generateDeviceUniqueId();
                                  loginUser();
                                } else {
                                  // Show toast message if validation fails
                                  showToast('Please enter valid credentials', Colors.red);
                                }
                              },
                              child: Text(
                                'Login Now',
                                style: TextStyle(fontSize: 15, color: color.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: color.button_color,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _launchURL('https://craftboxtechnology.com/contact-us/');
                                    },
                                    child: Text(
                                      'Contact to Admin',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _launchURL('https://craftboxtechnology.com/privacypolicy.php');
                                    },
                                    child: Text(
                                      'Privacy Policy',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Application Version v.$_appVersion',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
