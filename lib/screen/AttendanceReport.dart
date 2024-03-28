import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hrbox/constant/color.dart' as color;

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({super.key});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  List<String> report_type_list = ["item1","item2","item3"];


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
            ('Report'),
          style: TextStyle(color: color.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Report Type*", style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 5,),
              DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                ),
                selectedItem: "Live Attendance Report",
                items: report_type_list,
                itemAsString: (state) => state,

                onChanged: (String? newvalue) {
                  setState(() {
                    if (newvalue != null) {

                    }
                  });
                },
              ),
              SizedBox(height: 15,),
              Text("Barnch Name*", style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 5,),
              DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                ),
                selectedItem: "Select Branch name",
                items: report_type_list,
                itemAsString: (state) => state,

                onChanged: (String? newvalue) {
                  setState(() {
                    if (newvalue != null) {

                    }
                  });
                },
              ),
              SizedBox(height: 15,),
              Text("Department", style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 5,),
              DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                ),
                selectedItem: "Select Department",
                items: report_type_list,
                itemAsString: (state) => state,

                onChanged: (String? newvalue) {
                  setState(() {
                    if (newvalue != null) {

                    }
                  });
                },
              ),
              SizedBox(height: 15,),
              Text("Day Status", style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 5,),
              DropdownSearch<String>(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                ),
                selectedItem: "Select Day Status",
                items: report_type_list,
                itemAsString: (state) => state,

                onChanged: (String? newvalue) {
                  setState(() {
                    if (newvalue != null) {

                    }
                  });
                },
              ),
              SizedBox(height: 15,),
              Text("Search", style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 5,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search By Employee Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text("From Date*", style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text("To Date*", style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'From Date*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'To Date*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: (){

                    },
                    child: Text(
                      'Show',
                      style: TextStyle(fontSize: 15, color: color.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: color.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: (){

                    },
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 15, color: color.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                        backgroundColor: color.button_color,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
