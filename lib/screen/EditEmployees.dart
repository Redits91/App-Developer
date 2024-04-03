import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hrbox/constant/color.dart' as color;
import 'package:fluttertoast/fluttertoast.dart';
import '../constant/MyPreferences.dart';
import '../models/CommonModel.dart';
import '../retrofit.dart';

class AddEditEmployee extends StatefulWidget {
  late String id;

  AddEditEmployee({super.key, required this.id});

  @override
  State<AddEditEmployee> createState() => _AddEditEmployeeState();
}

class _AddEditEmployeeState extends State<AddEditEmployee> {
  MyPreferences preferences = new MyPreferences();

  List<String> report_type_list = ["item1", "item2", "item3"];
  bool isMale = false;
  bool isFemale = false;
  bool isLoading = false;
  int? selectedMaritalStatus;

  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  bool _isSameAddress = false;

  TextEditingController _employeeName = TextEditingController();
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _contectNumber = TextEditingController();
  TextEditingController _emergancyNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _nationality = TextEditingController();
  TextEditingController _aadharNumber = TextEditingController();
  TextEditingController _panNumber = TextEditingController();
  TextEditingController _currentAddressController = TextEditingController();
  TextEditingController _permanentAddressController = TextEditingController();

  String system_user_login_id = "";

  List<CommonModel> branch_list = [];
  String dropdown_branch_id = '';
  String dropdown_branch_name = '';
  CommonModel? selectedBranch;

  List<CommonModel> grade_list = [];
  String dropdown_grade_id = '0';
  String dropdown_grade_name = '';
  CommonModel? selectedGrade;

  List<CommonModel> referance_list = [];
  String dropdown_referance_id = '';
  String dropdown_referance_name = '';
  CommonModel? selectedreferance;

  List<CommonModel> state_list = [];
  String dropdown_state_id = '';
  String dropdown_state_name = '';
  CommonModel? selectedstate;

  List<CommonModel> headQuarter_list = [];
  String dropdown_headQuarter_id = '';
  String dropdown_headQuarter_name = '';
  CommonModel? selectedheadQuarter;

  @override
  void dispose() {
    _currentAddressController.dispose();
    _permanentAddressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedValue();
  }

  void getSharedValue() async {
    system_user_login_id =
        await preferences.getPreferences(MyPreferences.System_user_login_id);
    getBranch();
    getGrade();
    getReference();
    getState();
    getHeadQuarter();
    if (widget.id.isNotEmpty) {
      getEmployeebyid();
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

  getGrade() async {
    try {
      var response = await GetGrade(system_user_login_id);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            grade_list = List<CommonModel>.from(
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

  getReference() async {
    try {
      var response = await GetRefrence(system_user_login_id);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            referance_list = List<CommonModel>.from(
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

  getState() async {
    try {
      var response = await GetState(system_user_login_id);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            state_list = List<CommonModel>.from(
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

  getHeadQuarter() async {
    try {
      var response = await GetHeadQuarter(system_user_login_id);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        if (extractdata['ack'] == 1) {
          setState(() {
            headQuarter_list = List<CommonModel>.from(
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

  addEmployee() async {
    String gender = isMale ? "1" : (isFemale ? "2" : "");
    try {
      var response = await AddEmployee(
          system_user_login_id,
          _employeeName.text,
          dropdown_branch_id,
          dropdown_grade_id,
          dropdown_referance_id,
          dropdown_state_id,
          dropdown_headQuarter_id,
          _fatherName.text,
          gender,
          selectedMaritalStatus.toString(),
          _dateController.text,
          _contectNumber.text,
          _emergancyNumber.text,
          _email.text,
          _nationality.text,
          _aadharNumber.text,
          _panNumber.text,
          _currentAddressController.text,
          _permanentAddressController.text);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          showToast(extractedData['ack_msg'], color.green);
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

  getEmployeebyid() async {
    setState(() {
      isLoading = true; // Show loader
    });
    try {
      var response = await GetEmployeebyid(system_user_login_id, widget.id);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false; // Hide loader even on error
        });
        var extractedData = json.decode(response.body);
        if (extractedData['ack'] == 1) {
          _employeeName.text =
              extractedData['result'][0]['employee_name'].toString();
          dropdown_branch_id =
              extractedData['result'][0]['branch_id'].toString();
          dropdown_grade_id = extractedData['result'][0]['grade_id'].toString();
          dropdown_referance_id =
              extractedData['result'][0]['refrences_id'].toString();
          dropdown_state_id = extractedData['result'][0]['state_id'].toString();
          dropdown_headQuarter_id =
              extractedData['result'][0]['head_quarter'].toString();
          _fatherName.text =
              extractedData['result'][0]['father_spouse_name'].toString();
          extractedData['result'][0]['gender'] == "1"
              ? isMale = true
              : isFemale = true;
          extractedData['result'][0]['marital_status'] == "1"
              ? selectedMaritalStatus = 1
              : (extractedData['result'][0]['marital_status'] == "2"
                  ? selectedMaritalStatus = 2
                  : selectedMaritalStatus = 3);
          _dateController.text =
              extractedData['result'][0]['date_of_birth'].toString();
          _contectNumber.text =
              extractedData['result'][0]['contact_number'].toString();
          _emergancyNumber.text = extractedData['result'][0]
                  ['emergency_num_and_con_num']
              .toString();
          _email.text = extractedData['result'][0]['email_id'].toString();
          _nationality.text =
              extractedData['result'][0]['nationality'].toString();
          _aadharNumber.text =
              extractedData['result'][0]['aadhar_card_number'].toString();
          _panNumber.text =
              extractedData['result'][0]['pan_card_number'].toString();
          _currentAddressController.text =
              extractedData['result'][0]['current_address'].toString();
          _permanentAddressController.text =
              extractedData['result'][0]['permanent_address'].toString();
          setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.id.isNotEmpty ? "Edit Employee" : "Add Employee",
          style: TextStyle(color: color.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                color: color.white,
                surfaceTintColor: color.white,
                shadowColor: null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  // side: BorderSide(color: Colors.black26, width: 1.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: isLoading,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Text(
                        'Employee Name*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _employeeName,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Branch Details*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DropdownButtonFormField<CommonModel>(
                        decoration: InputDecoration(
                          hintText: "Select Branch",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        value: branch_list == '0' || branch_list.isEmpty
                            ? null
                            : branch_list.firstWhere(
                              (e) => e.id == dropdown_branch_id,
                          orElse: () => branch_list.first,
                        ),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Grade*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DropdownButtonFormField<CommonModel>(
                        decoration: InputDecoration(
                          hintText: "Select Grade",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        value: dropdown_grade_id == '0' || grade_list.isEmpty
                            ? null
                            : grade_list.firstWhere(
                                (e) => e.id == dropdown_grade_id,
                                orElse: () => grade_list.first,
                              ),
                        items: grade_list.map((state) {
                          return DropdownMenuItem<CommonModel>(
                            value: state,
                            child: Text(state.name),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            dropdown_grade_id = newvalue!.id;
                            dropdown_grade_name = newvalue!.name;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'References*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DropdownButtonFormField<CommonModel>(
                        decoration: InputDecoration(
                          hintText: "Select Reference",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        value: dropdown_referance_id == '0' ||
                                referance_list.isEmpty
                            ? null
                            : referance_list.firstWhere(
                                (e) => e.id == dropdown_referance_id,
                                orElse: () => referance_list.first,
                              ),
                        items: referance_list.map((state) {
                          return DropdownMenuItem<CommonModel>(
                            value: state,
                            child: Text(state.name),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            dropdown_referance_id = newvalue!.id;
                            dropdown_referance_name = newvalue!.name;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'State*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DropdownButtonFormField<CommonModel>(
                        decoration: InputDecoration(
                          hintText: "Select State",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        value: dropdown_state_id == '0' || state_list.isEmpty
                            ? null
                            : state_list.firstWhere(
                                (e) => e.id == dropdown_state_id,
                                orElse: () => state_list.first,
                              ),
                        items: state_list.map((state) {
                          return DropdownMenuItem<CommonModel>(
                            value: state,
                            child: Text(state.name),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            dropdown_state_id = newvalue!.id;
                            dropdown_state_name = newvalue!.name;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Head Quarter*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DropdownButtonFormField<CommonModel>(
                        decoration: InputDecoration(
                          hintText: "Select HeadQuarter",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        value: dropdown_headQuarter_id == '0' ||
                                headQuarter_list.isEmpty
                            ? null
                            : headQuarter_list.firstWhere(
                                (e) => e.id == dropdown_headQuarter_id,
                                orElse: () => headQuarter_list.first,
                              ),
                        items: headQuarter_list.map((state) {
                          return DropdownMenuItem<CommonModel>(
                            value: state,
                            child: Text(state.name),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            dropdown_headQuarter_id = newvalue!.id;
                            dropdown_headQuarter_name = newvalue!.name;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Father's / Spouse Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _fatherName,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isMale,
                            onChanged: (bool? value) {
                              setState(() {
                                isMale = value ?? false;
                                if (isMale) {
                                  isFemale =
                                      false; // Uncheck female if male is checked
                                }
                              });
                            },
                            activeColor: color.primary_color,
                          ),
                          Text('Male'),
                          SizedBox(width: 20),
                          Checkbox(
                            value: isFemale,
                            onChanged: (bool? value) {
                              setState(() {
                                isFemale = value ?? false;
                                if (isFemale) {
                                  isMale =
                                      false; // Uncheck male if female is checked
                                }
                              });
                            },
                            activeColor: color.primary_color,
                          ),
                          Text('Female'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Marital Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<int>(
                            value: 1,
                            groupValue: selectedMaritalStatus,
                            onChanged: (value) {
                              setState(() {
                                selectedMaritalStatus = value;
                              });
                            },
                            activeColor: color.primary_color,
                          ),
                          Text('Single'),
                          Radio<int>(
                            value: 2,
                            groupValue: selectedMaritalStatus,
                            onChanged: (value) {
                              setState(() {
                                selectedMaritalStatus = value;
                              });
                            },
                            activeColor: color.primary_color,
                          ),
                          Text('Married'),
                          Radio<int>(
                            value: 3,
                            groupValue: selectedMaritalStatus,
                            onChanged: (value) {
                              setState(() {
                                selectedMaritalStatus = value;
                              });
                            },
                            activeColor: color.primary_color,
                          ),
                          Text('Divorced'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Date Of Birth*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        // Set the text field as read-only to prevent manual text input
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Contact Number*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _contectNumber,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Emergancy Number And Contact Number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _emergancyNumber,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email ID",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _email,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nationality",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _nationality,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Aadhar Card Number*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _aadharNumber,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pan Card Number*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _panNumber,
                        initialValue: null,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Current Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _currentAddressController,
                        initialValue: null,
                        maxLines: 3,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: color.primary_color,
                            value: _isSameAddress,
                            onChanged: (value) {
                              setState(() {
                                _isSameAddress = value!;
                                if (_isSameAddress) {
                                  _permanentAddressController.text =
                                      _currentAddressController.text;
                                }
                              });
                            },
                          ),
                          Text('Click on chech box if both address\nare same'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Permanent Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: _permanentAddressController,
                        maxLines: 3,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addEmployee();
                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(fontSize: 15, color: color.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: color.button_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
    }
  }
}
