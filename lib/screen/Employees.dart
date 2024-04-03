import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrbox/constant/color.dart' as color;
import 'package:hrbox/models/EmployeeModel.dart';
import 'package:hrbox/retrofit.dart';
import 'package:hrbox/screen/EditEmployees.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/MyPreferences.dart';
import '../models/CommonModel.dart';


class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  List<EmployeeModel> employee_data_list = [];
  TextEditingController filterTextController = TextEditingController();

  bool isLoading = false;
  MyPreferences preferences = new MyPreferences();
  String system_user_login_id = "";
  String ll = "0";
  String ul = "20";

  List<CommonModel> branch_list = [];
  String dropdown_branch_id = '';
  String dropdown_branch_name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedValue();
    getEmployee("");
  }

  void getSharedValue() async {
    system_user_login_id = await preferences.getPreferences(MyPreferences.System_user_login_id);
    getBranch();
  }

  getEmployee(String type) async {
    setState(() {
      isLoading = true;
    });
    try {
      var response;
      // response = await GetEmployee(system_user_login_id,ll, ul);
      if (type == "1"){
        response = await GetEmployeeFiltter(system_user_login_id,dropdown_branch_id,filterTextController.text);
      } else {
        response = await GetEmployee(system_user_login_id,ll, ul);
      }
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          // showToast(extractedData['ack_msg'], color.green);
          var results=extractedData['result'];
          setState(() {
            for (var result in results) {
              EmployeeModel em = EmployeeModel();
              em.emp_id = result['id'];
              em.employee_code = result['employee_code'];
              em.employee_name = result['employee_name'];
              em.branch_name = result['branch_name'];
              em.mobile_no = result['contact_number'];
              em.department = result['department_name'];
              employee_data_list.add(em);
            }
          });
        } else {
          showToast(extractedData['ack_msg'], color.red);
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
        showToast("Network error occurred please try again", color.red);
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  getBranch() async {
    try {
      var response = await GetBranch(system_user_login_id);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            branch_list = List<CommonModel>.from(
                extractdata["result"].map((x) => CommonModel.fromJson(x)));
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

  /*getEmployeeFiltter() async {
    try {
      var response = await GetEmployeeFiltter(system_user_login_id,dropdown_branch_id,filterTextController.text);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
        } else {
          print("Error: ${extractdata['ack_msg']}");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Employees", style: TextStyle(color: color.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add your action here
              _showAlertDialog(context);
            },
            icon: Icon(Icons.filter_list, color: color.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Visibility(
              visible: isLoading,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: employee_data_list.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Card(
                        color: color.white,
                        surfaceTintColor: color.white,
                        shadowColor: null,
                        // elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Employee Code',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Employee Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Branch Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Mobile No.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Department',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(' :  ' + employee_data_list[index].employee_code,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(' :  ' + employee_data_list[index].employee_name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(' :  ' + employee_data_list[index].branch_name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(' :  ' + employee_data_list[index].mobile_no,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(' :  ' + employee_data_list[index].department,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 20,
                        child: IconButton(
                          onPressed: () {
                            if (index >= 0 && index < employee_data_list.length) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEditEmployee(id: employee_data_list[index].emp_id)
                                  )
                              );
                            } else {
                              // Handle index out of bounds error
                              print('Index out of bounds or employee_data_list is empty');
                            }                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  );
                        /*Positioned(
                          bottom: 0,
                          right: 20,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditEmployee()));
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      */
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            // Handle FAB press
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditEmployee(id: "")));
          },
          child: Container(height: 25, width: 25,child: Icon(Icons.add, color: color.white,)),
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

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: color.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Branch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<CommonModel>(
                decoration: InputDecoration(
                  hintText: "Select Branch",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                value: null,
                items: branch_list.map((state) {
                  return DropdownMenuItem<CommonModel>(
                    value: state,
                    child: Text(state.name),
                  );
                }).toList(),
                onChanged: (newvalue) {
                  setState(() {
                    dropdown_branch_id = newvalue!.id;
                    dropdown_branch_name = newvalue!.name;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Search by name & number:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: filterTextController,
                decoration: InputDecoration(
                  hintText: "Enter Name & Number",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                )
              ),
              child: Text('CANCEL',style: TextStyle(color: color.white),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                  )
              ),
              child: Text('CLEAR',style: TextStyle(color: color.white)),
              onPressed: () {
                setState(() {
                  dropdown_branch_id = "";
                  dropdown_branch_name = "";
                  filterTextController.clear();
                });
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color.button_color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                  )
              ),
              child: Text('APPLY',style: TextStyle(color: color.white)),
              onPressed: () {
                getEmployee("1");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}
