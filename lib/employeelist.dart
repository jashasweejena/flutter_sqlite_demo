import 'package:flutter/material.dart';
import 'package:sqflite_demo/database/database.dart';
import 'package:sqflite_demo/model/Employee.dart';

Future<List<Employee>> fetchEmployeeFromDatabase () async {
  var dbHelper = DBHelper();
  Future<List<Employee>> employees = dbHelper.getEmployees();
  return employees;
}

class MyEmployeeList extends StatefulWidget {
  @override
  _MyEmployeeListState createState() => _MyEmployeeListState();
}

class _MyEmployeeListState extends State<MyEmployeeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee list"),
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child:  FutureBuilder <List<Employee>>(
          future: fetchEmployeeFromDatabase(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snapshot.data[index].firstName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),),
                        Text(
                        snapshot.data[index].lastName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),),
                        Divider(),
                    ],
                  );
                },
              );
            }

            else if (snapshot.data.length == 0){
              return Text("Data not found");
            }
            return Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(),
            );
          },
        ) ,
      ),
    );
  }
}