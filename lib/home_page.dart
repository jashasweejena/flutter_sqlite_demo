import 'package:flutter/material.dart';
import 'package:sqflite_demo/database/database.dart';
import 'package:sqflite_demo/employeelist.dart';
import 'package:sqflite_demo/model/Employee.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String firstName;
  String lastName;
  String mobileNo;
  String emailId;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Saving employee"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list),
            tooltip: "Next Choice",
            onPressed: () => Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => MyEmployeeList()
              )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "First Name"),
                validator: (val) => 
                        val.length == 0 ? "Enter Firstname" : null,
                onSaved: (val) => this.firstName = val,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Enter Last Name"
                ),
                validator: (val) =>
                        val.length == 0 ? "Enter Last Name" : null,
                onSaved: (val) => this.lastName = val,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter mobile number"
                ),
                validator: (val) =>
                        val.length == 0 ? "Enter mobile number" : null,
                onSaved: (val) => this.mobileNo = val,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email-ID"
                ),
                validator: (val) => 
                          val.length == 0 ? "Enter Email-ID" : null,
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: _submit,
                  child: Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if(this.formKey.currentState.validate()){
      formKey.currentState.save();
    }

    var employee = Employee(firstName, lastName, mobileNo, emailId);
    var dbHelper = DBHelper();
    dbHelper.saveEmployee(employee);
    _showSnackBar("Data Saved Successfully");
  }

  void _showSnackBar(String text){
    scaffoldKey.currentState
    .showSnackBar(SnackBar(content: Text(text),));
  }
}

