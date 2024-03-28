import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hrbox/constant/color.dart' as color;

class EditEmployee extends StatefulWidget {
  const EditEmployee({super.key});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  List<String> report_type_list = ["item1","item2","item3"];
  bool isMale = false;
  bool isFemale = false;
  int? selectedMaritalStatus;

  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  TextEditingController _currentAddressController = TextEditingController();
  TextEditingController _permanentAddressController = TextEditingController();
  bool _isSameAddress = false;

  @override
  void dispose() {
    _currentAddressController.dispose();
    _permanentAddressController.dispose();
    super.dispose();
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
          "Edit Employee", style: TextStyle(color: color.white),
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
                      Text('Employee Name*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 10,),
                      Text('Branch Details*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        selectedItem: "Select Branch",
                        items: report_type_list,
                        itemAsString: (state) => state,
        
                        onChanged: (String? newvalue) {
                          setState(() {
                            if (newvalue != null) {
        
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('Grade*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        items: report_type_list,
                        itemAsString: (state) => state,
                        onChanged: (String? newvalue) {
                          setState(() {
                            if (newvalue != null) {
        
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('References*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        items: report_type_list,
                        itemAsString: (state) => state,
                        onChanged: (String? newvalue) {
                          setState(() {
                            if (newvalue != null) {
        
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('State*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        items: report_type_list,
                        itemAsString: (state) => state,
                        onChanged: (String? newvalue) {
                          setState(() {
                            if (newvalue != null) {
        
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('Head Quarter*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        items: report_type_list,
                        itemAsString: (state) => state,
                        onChanged: (String? newvalue) {
                          setState(() {
                            if (newvalue != null) {
        
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      Text("Father's / Spouse Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 20,),
                      Text("Gender",
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
                                  isFemale = false; // Uncheck female if male is checked
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
                                  isMale = false; // Uncheck male if female is checked
                                }
                              });
                            },
                            activeColor: color.primary_color,
                          ),
                          Text('Female'),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Marital Status",
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
                            value: 0,
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
                            value: 1,
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
                            value: 2,
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
                      SizedBox(height: 20,),
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
                      Text("Contact Number*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 10,),
                      Text("Emergancy Number And Contact Number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 10,),
                      Text("Email ID",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 10,),
                      Text("Nationality",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 10,),
                      Text("Aadhar Card Number*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextFormField(
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
                      SizedBox(height: 10,),
                      Text("Current Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
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
                      SizedBox(height: 10,),
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
                                  _permanentAddressController.text = _currentAddressController.text;
                                }
                              });
                            },
                          ),
                          Text('Click on chech box if both address\nare same'),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Permanent Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 3,),
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
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {},
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
