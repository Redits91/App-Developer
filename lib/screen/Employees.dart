import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrbox/constant/color.dart' as color;
import 'package:hrbox/screen/EditEmployees.dart';


class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
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
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
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
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text('Employee Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text('Branch Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text('Mobile No.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text('Department',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(' :  Employee Code',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(' :  Employee Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(' :  Branch Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(' :  Mobile No.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(' :  Department',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditEmployee()));
                      },
                      icon: Icon(Icons.edit),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            // Handle FAB press
          },
          child: Container(height: 25, width: 25,child: Icon(Icons.add)),
          backgroundColor: color.primary_color,
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
