import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hrbox/constant/MyPreferences.dart';
import 'package:hrbox/constant/color.dart' as color;
import 'package:hrbox/models/CommonModel.dart';
import 'package:hrbox/retrofit.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'myQRcode.dart';

class CanteenIN extends StatefulWidget {
  final String id;

  const CanteenIN({Key? key, required this.id}) : super(key: key);

  @override
  State<CanteenIN> createState() => _CanteenINState();
}

class _CanteenINState extends State<CanteenIN> {

  MyPreferences preferences = new MyPreferences();

  List<CommonModel> branch_list = [];
  String dropdown_branch_id = '';
  String dropdown_branch_name = '';
  CommonModel? selectedBranch;

  List<CommonModel> category_list = [];
  String dropdown_category_id = '';
  String dropdown_category_name = '';
  CommonModel? selectedCategory;

  bool hideSelectCategory = false;
  String login_user_type = "";
  String ll = "0";
  String ul = "20";
  String system_user_login_id = "";

  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;



  List<String> data = [
    'branch 1','branch 2','branch 3'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedValue();
    getCategory();
    _dateController.text = "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year.toString()}";
    if (widget.id == '1' || widget.id == '2') {
      setState(() {
        hideSelectCategory = true;
      });
    }
  }

  void getSharedValue() async {
    login_user_type = await preferences.getPreferences(MyPreferences.login_user_type);
    system_user_login_id = await preferences.getPreferences(MyPreferences.System_user_login_id);
    print("login_user_type " + login_user_type);
    getBranch();
  }
  getBranch() async {
    try {
      var response = await GetBranch(system_user_login_id);
      if (response.statusCode == 200) {
        print("system_user_login_id " + system_user_login_id);
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            branch_list = List<CommonModel>.from(extractdata["result"].map((x) => CommonModel.fromJson(x)));
          });
        } else {
          print("Error: ${extractdata['ack_msg']}");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch(e) {
      print("Error: $e");
    }
  }

  getCategory() async {
    try {
      var response = await GetCategory();
      if (response.statusCode == 200) {
        print("responce : ${response.statusCode}");
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            category_list = List<CommonModel>.from(extractdata["result"].map((x) => CommonModel.fromJson(x)));
          });
        } else {
          print("Error: ${extractdata['ack_msg']}");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch(e) {
      print("Error: $e");
    }
  }
  List<dynamic> attendanceData = [];
  List<dynamic> date = [];
  List<dynamic> time = [];
  getAttendanceData() async {
    try {
      var response = await GetAttendanceData(selectedBranch?.id ?? "", widget.id,_dateController.text, ll, ul);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            attendanceData.clear();
            date.clear();
            time.clear();
            var results = extractdata['result'];
            for (var result in results) {
              attendanceData.add(result['emp_name']);
              date.add(result['date']);
              time.add(result['time']); // Adding time
            }
          });
        } else {
          print("Error: ${extractdata['ack_msg']}");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  getAttendanceDataCanteen() async {
    try {
      var response = await GetAttendanceDataforCanteen(selectedCategory?.id ?? "", dropdown_category_id,_dateController.text, ll, ul);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            attendanceData.clear();
            date.clear();
            time.clear();
            var results = extractdata['result'];
            for (var result in results) {
              attendanceData.add(result['emp_name']);
              date.add(result['date']);
              time.add(result['time']); // Adding time
            }
          });
        } else {
          print("Error: ${extractdata['ack_msg']}");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  FutureOr onGoBack(value) async {
    print("hey");
    attendanceData.clear();
    data.clear();
    time.clear();
    ul = "0";
    getAttendanceData();
    getAttendanceDataCanteen();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color.primary_color),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.id == "1" ? "Attendance IN" : (widget.id == "2" ? "Attendance OUT" : "Canteen IN"),
          style: TextStyle(color: color.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("Branch Name", style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10,),
            DropdownSearch<String>(
              dropdownSearchDecoration: InputDecoration(
                hintText: "Select Branch",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5),
              ),
              selectedItem: selectedBranch?.name,
              items: branch_list.map((state) => state.name).toList(),
              itemAsString: (state) => state,
              onChanged: (String? newvalue) {
                setState(() {
                  if (newvalue != null) {
                    selectedBranch = branch_list.firstWhere((state) => state.name == newvalue, orElse: () => CommonModel(id: '', name: ''));
                    if (selectedBranch != null) {
                      dropdown_branch_id = selectedBranch!.id;
                      dropdown_branch_name = selectedBranch!.name;
                      if (widget.id == "1") {
                        getAttendanceData();
                      }
                      if (widget.id == "2") {
                        getAttendanceData();
                      }
                    } else {
                      // Handle the case when selectedstate is null
                    }
                  }
                });
              },
            ),
            SizedBox(height: 5,),
            Visibility(
              visible: !hideSelectCategory,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select category", style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  DropdownSearch<String>(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: "Select Category",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(5),
                    ),
                    selectedItem: selectedCategory?.name,
                    items: category_list.map((state) => state.name).toList(),
                    itemAsString: (state) => state,
                    onChanged: (String? newvalue) {
                      setState(() {
                        if (newvalue != null) {

                          selectedCategory = category_list.firstWhere((state) => state.name == newvalue, orElse: () => CommonModel(id: '', name: ''));

                          if (selectedCategory != null) {
                            dropdown_category_id = selectedCategory!.id;
                            dropdown_category_name = selectedCategory!.name;
                            if (widget.id == "3") {
                              getAttendanceDataCanteen();
                            }
                            print(dropdown_category_id);
                          } else {
                            // Handle the case when selectedstate is null
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Text("Date Of Birth*",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 3,),
            TextFormField(
              controller: _dateController,
              readOnly: true, // Set the text field as read-only to prevent manual text input
              onTap: () {
                _selectDate(context);
              },
              initialValue: null,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color.button_color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Row(
                  children: [
                    Text(
                      'Emp Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(right: 30)),
                    Container(
                      height: 40, // Adjust the height to cover the entire list
                      width: 2,
                      color: color.gray,
                    ),
                    Padding(padding: EdgeInsets.only(left: 30)),
                    Text(
                      'Date & Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  attendanceData[index],
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: 27)),
                              Container(
                                height: 40,
                                width: 2,
                                color: Colors.grey, // Assuming color is defined elsewhere
                              ),
                              Padding(padding: EdgeInsets.only(left: 30)),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  '${date[index]} ${time[index]}',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            decoration: BoxDecoration(color: Colors.grey), // Assuming color is defined elsewhere
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            /*Container(
              height: 300,
              width: 350,
              child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  // Check if the index is within the range of the date list
                  if (index < date.length) {
                    return Container(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${attendanceData[index]}', style: TextStyle(fontSize: 12)),
                            Text('${date[index]} ' + '${time[index]}', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // Handle the case when the date list does not have enough elements
                    *//*return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${attendanceData[index]}', style: TextStyle(fontSize: 12)),
                          Text('No date available', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );*//*
                  }
                },
              ),
            )*/
          ],
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            // Handle FAB press
            if (dropdown_branch_id.isEmpty){
              showToast("Please select Branch", color.red);
            } else if (widget.id == "3" && dropdown_category_id.isEmpty) {
              showToast("Please select Category", color.red);
            } else {

              Navigator.push(context, MaterialPageRoute(builder: (context) => myQRcode(id: widget.id, branchName: dropdown_branch_name, branchID: dropdown_branch_id))).then((value) => (onGoBack));
            }

          },
          child: Container(height: 25, width: 25,child: Image.asset('assets/qr.png',color: color.white,)),
          backgroundColor: color.primary_color,
          shape: CircleBorder(),
        ),
      ),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(

          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              surfaceTint: Colors.white,

            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
        // "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
        "${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString()}";
      });
    }
  }
}
