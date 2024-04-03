import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrbox/constant/color.dart' as color;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hrbox/models/rights_model.dart';
import 'package:hrbox/retrofit.dart';
import 'package:hrbox/screen/AttendanceReport.dart';
import 'package:hrbox/screen/CanteenIN.dart';
import 'package:hrbox/screen/Employees.dart';
import 'package:hrbox/screen/Login.dart';
import 'package:hrbox/screen/myQRcode.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/MyPreferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool hideCard = false;
  int _current = 0;
  String _appVersion = '';
  String system_user_login_id = "";
  String login_user_type = "";
  String uniqueId = "";
  String emp_id = "";
  String myqrcode = "";
  String app_out_side_view_flag = "";
  String app_out_side_insert_flag = "";

  String employee_view = "";
  String attendance_in = "";
  String attendance_out = "";
  String report = "";
  String canteen_in = "";
  String self_attendance = "";

  MyPreferences prefeernces = new MyPreferences();
  List<String> imageAssetPaths = [];
  List<rights_model> rights_array_attendance = [];
  List<rights_model> rights_array_canteen = [];
  List<rights_model> rights_array_employees = [];


  Future<void> create_dashboard_array() async {

   String attendance_in_type = "1";
   rights_model rm = rights_model();
    rm.id = '0';
    rm.name = 'Attendance\nIN';
    rm.IconButton = IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CanteenIN(id: attendance_in_type)));
        },
        icon: Icon(Icons.arrow_downward, size: 40));
    rm.ontap = 'Attendance_IN';
    if (attendance_in == '1') {
      rights_array_attendance.add(rm);
    }

   String attendance_out_type = "2";
   rights_model rm1 = rights_model();
    rm1.id = '1';
    rm1.name = 'Attendance\nOUT';
    rm1.IconButton = IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CanteenIN(id: attendance_out_type)));
        },
        icon: Icon(Icons.arrow_upward, size: 40));
    rm1.ontap = 'Attendance_out';
    if (attendance_out == '1') {
      rights_array_attendance.add(rm1);
    }

    rights_model rm2 = rights_model();
    rm2.id = '2';
    rm2.name = 'Attendance Report';
    rm2.IconButton = IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceReport()));
        },
        icon: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/attendance_report.png'),
        )
    );
    rm2.ontap = 'Attendance_Report';
    if (report == '1') {
      rights_array_attendance.add(rm2);
    }

    rights_model rm3 = rights_model();
    rm3.id = '3';
    rm3.name = 'Canteen\nIN';
    rm3.IconButton = IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (contex) => CanteenIN(id: rm3.id,)));
        },
        icon: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/canteen.png'),
        )
    );
    rm3.ontap = 'Canteen_IN';
    if (canteen_in == '1') {
      rights_array_canteen.add(rm3);
    }

    rights_model rm4 = rights_model();
    rm4.id = '4';
    rm4.name = 'Canteen Report';
    rm4.IconButton = IconButton(
        onPressed: () {

        },
        icon: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/report.png', color: color.black,),
        )
    );
    rm4.ontap = 'Canteen_Report';
   if (report == '1') {
     rights_array_canteen.add(rm4);
   }



    rights_model rm5 = rights_model();
    rm5.id = '5';
    rm5.name = 'Employees';
    rm5.IconButton = IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (contex) => Employees()));
        },
        icon: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/employees.png', color: color.black,),
        )
    );
    rm5.ontap = 'Employees';
    if (employee_view == '1') {
      rights_array_employees.add(rm5);
    }

    rights_model rm6 = rights_model();
    rm6.id = '6';
    rm6.name = 'General Report';
    rm6.IconButton = IconButton(
        onPressed: () {

        },
        icon: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/general_report.png', color: color.black,),
        )
    );
    rm6.ontap = 'General_Report';
   if (report == '1') {
     rights_array_employees.add(rm6);
   }

   rights_model rm7 = rights_model();
   rm7.id = '7';
   rm7.name = 'Self Attendance\nIN/OUT';
   rm7.IconButton = IconButton(
       onPressed: () {

       },
       icon: Icon(Icons.fingerprint, size: 40));
   rm7.ontap = 'Self_Attendance_IN_OUT';
   if (emp_id != "0" && self_attendance == '1') {
     rights_array_attendance.add(rm7);
   }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefeernces = MyPreferences();
    getAppVersion();
    getSharedValue();

  }

  void getSharedValue() async {
    system_user_login_id = await prefeernces.getPreferences(MyPreferences.System_user_login_id);
    login_user_type = await prefeernces.getPreferences(MyPreferences.login_user_type);
    uniqueId = await prefeernces.getPreferences(MyPreferences.device_token);

    emp_id = await prefeernces.getPreferences(MyPreferences.emp_id);
    myqrcode = await prefeernces.getPreferences(MyPreferences.myqrcode);
    app_out_side_view_flag = await prefeernces.getPreferences(MyPreferences.app_out_side_view_flag);
    app_out_side_insert_flag = await prefeernces.getPreferences(MyPreferences.app_out_side_insert_flag);

    print("user_login_is " + system_user_login_id);
    print("user_login_type " + login_user_type);
    print("uniqueId " + uniqueId);
    print("emp_id "+emp_id);
    getBanner();
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  logoutUser() async {
    try {
      var response = await LogoutUser(system_user_login_id,login_user_type, uniqueId);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          showToast(extractedData['ack_msg'], color.green);
          prefeernces.clearPreferences();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));

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


  getBanner() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await GetBanner(/*system_user_login_id*/"22",/*login_user_type*/"2", uniqueId);
      print("uniqueId " + uniqueId);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        print("responce : ${response.statusCode}");
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          var banners = extractedData['banners'];
          for (var banner in banners) {
              imageAssetPaths.add(banner['image_path']) ;
          }

          var rightss = extractedData['rights'];
          for (var rights in rightss) {

            if (rights['page_slug'] == 'app_employee'){
              employee_view=rights['view_flag'];
              print("emp123 $employee_view");
              prefeernces.setPreferences(MyPreferences.app_employee_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.app_employee_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.app_employee_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.app_employee_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.app_employee_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.app_employee_print_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.app_employee_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.app_employee_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.app_employee_page_name, rights['page_name']);
            }
            if (rights['page_slug'] == 'app_attendance_in') {
              attendance_in = rights['view_flag'];
              print("attendance_in " + attendance_in);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_export_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.app_attendance_in_page_name, rights['page_name']);
            }
            if (rights['page_slug'] == 'app_attendance_out') {
              attendance_out = rights['view_flag'];
              print("attendance_out " + attendance_out);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_print_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.app_attendance_out_page_name, rights['page_name']);
            }
            if (rights['page_slug'] == 'app_report') {
              report = rights['view_flag'];
              prefeernces.setPreferences(MyPreferences.report_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.report_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.report_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.report_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.report_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.report_print_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.report_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.report_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.report_page_name, rights['page_name']);
            }
            if (rights['page_slug'] == 'app_self_attendance') {
              self_attendance = rights['view_flag'];
              prefeernces.setPreferences(MyPreferences.app_self_attendance_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_print_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.app_self_attendance_page_name, rights['page_name']);
            }
            if (rights['page_slug'] == 'app_out_side_attendance') {
              prefeernces.setPreferences(MyPreferences.app_out_side_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.app_out_side_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.app_out_side_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.app_out_side_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.app_out_side_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.app_out_side_print_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.app_out_side_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.app_out_side_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.app_out_side_page_name, rights['page_name']);
            }
            if (rights['page_slug'] == 'app_canteen_in') {
              canteen_in = rights['view_flag'];
              prefeernces.setPreferences(MyPreferences.app_canteen_in_view_flag, rights['view_flag']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_insert_flag, rights['insert_flag']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_update_flag, rights['update_flag']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_delete_flag, rights['delete_flag']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_export_flag, rights['export_flag']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_print_flag, rights['print_flag']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_page_id, rights['page_id']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_page_slug, rights['page_slug']);
              prefeernces.setPreferences(MyPreferences.app_canteen_in_page_name, rights['page_name']);
            }
          }

          if (emp_id != "0" && app_out_side_view_flag == "1" && app_out_side_insert_flag == "1") {
            setState(() {
              hideCard = true;
            });
          } else {
            setState(() {
              hideCard = false;
            });
          }


          try {
            //rightsPreference();
            create_dashboard_array();
          } catch(e) {

          }
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color.primary_color));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          "HRBOX",
          style: TextStyle(color: color.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: isLoading,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            CarouselSlider(
              items: imageAssetPaths.map((path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.network(
                        path, // Use Image.asset to load local asset images
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(milliseconds: 5000),
                autoPlayAnimationDuration: Duration(milliseconds: 400),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: false,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageAssetPaths.map((path) {
                int index = imageAssetPaths.indexOf(path);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.black : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Visibility(
              visible: hideCard,
              child: Card(
                margin: EdgeInsets.all(10),
                color: color.white,
                surfaceTintColor: color.white,
                shadowColor: null,
                // elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.fingerprint, size: 70,color: color.red,)),
                          Text('Punch In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Text(
                              '00:00:00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                  fontSize: 20
                              ),
                            ),
                          ),
                          Text('Remaining\nWorking Time',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 15
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Text("0:0:0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                  fontSize: 20
                              ),
                            ),
                          ),
                          Text('Total Working\nTime',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 15
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: rights_array_attendance.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(left: 14),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TextView for "Attendance"
                    Text(
                      "Attendance",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54, // Assuming colorPrimaryDark
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8), // Space between text and line
                    // Orange Horizontal Line
                    Expanded(
                      child: Container(
                        height: 2,
                        color: color.button_color, // Assuming button_background
                        margin: EdgeInsets.only(left: 8, right: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              itemCount: rights_array_attendance.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height:77,
                      width: 77,
                      child: Card(
                        elevation: 5.0,
                        color: color.white,
                        surfaceTintColor: color.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0)),
                        child: rights_array_attendance[index].IconButton,
                        // child: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(rights_array_attendance[index].name, textAlign: TextAlign.center, style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),

                    // Text('prospect', overflow: TextOverflow.ellipsis,maxLines: 2,),
                  ],

                );
              },
            ),
            Visibility(
              visible: rights_array_canteen.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(left: 14),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TextView for "Attendance"
                    Text(
                      "Canteen",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54, // Assuming colorPrimaryDark
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8), // Space between text and line
                    // Orange Horizontal Line
                    Expanded(
                      child: Container(
                        height: 2,
                        color: color.button_color, // Assuming button_background
                        margin: EdgeInsets.only(left: 8, right: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3

              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              itemCount: rights_array_canteen.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height:77,
                      width: 77,
                      child: Card(
                        elevation: 5.0,
                        color: color.white,
                        surfaceTintColor: color.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0)),
                        child: rights_array_canteen[index].IconButton,
                        // child: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(rights_array_canteen[index].name, textAlign: TextAlign.center, style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold))
                  ],
                );
              },
            ),
            Visibility(
              visible: rights_array_employees.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(left: 14),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TextView for "Attendance"
                    Text(
                      "Employee",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54, // Assuming colorPrimaryDark
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8), // Space between text and line
                    // Orange Horizontal Line
                    Expanded(
                      child: Container(
                        height: 2,
                        color: color.button_color, // Assuming button_background
                        margin: EdgeInsets.only(left: 8, right: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3

              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              itemCount: rights_array_employees.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height:77,
                      width: 77,
                      child: Card(
                        elevation: 5.0,
                        color: color.white,
                        surfaceTintColor: color.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0)),
                        child: rights_array_employees[index].IconButton,
                        // child: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(rights_array_employees[index].name, textAlign: TextAlign.center, style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold))
                  ],
                );
              },
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: color.white,
        surfaceTintColor: color.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: color.primary_color, // Change the color here
                    ),
                    child: SizedBox(
                      width: 10, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      child: Image.asset(
                        'assets/hrbox.png',
                        fit: BoxFit.contain, // Preserve image aspect ratio
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700]),),
                    onTap: () {
                      // Handle item 1 tap
                      Navigator.pop(context);
                    },
                  ),
                  Visibility(
                    visible: myqrcode != "" && emp_id != "0",
                    child: ListTile(
                      leading: Icon(Icons.qr_code),
                      title: Text('My QR', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700])),
                      onTap: () {
                        // Handle item 2 tap
                        Navigator.push(context, MaterialPageRoute(builder: (context) => myQRcode(id : "",branchName: "",branchID: "",))).then((value) {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700])),
                    onTap: () {
                      // Handle item 2 tap
                      _showAlertDialog(context);
                    },
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Application Version v.$_appVersion',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 12
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to Logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                // Handle the confirm action
                logoutUser();
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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

}
