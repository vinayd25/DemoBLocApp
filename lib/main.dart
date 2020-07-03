import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bloc/employee_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Employee List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    employeeBloc.fetchEmployeeRecords();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: employeeBloc.employee,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                print("Inside UI: snapshot: ${snapshot.data}");
                if(snapshot.hasData){
                  List<dynamic> employeeList = snapshot.data;
                  if(employeeList.length > 0){
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: ClipOval(
                                    child: Container(
                                        height: 50.0,
                                        //margin: const EdgeInsets.all(20),
                                        width:  50,
                                        decoration: BoxDecoration(color: Colors.lightBlue,
                                        border: Border.all(color: Colors.lightBlue, width: 0.0),
                                        borderRadius: BorderRadius.all(Radius.elliptical(50, 50))), // this line makes the coffee.
                                        child: Center(child: Text(employeeList[index]["id"], style: TextStyle(color: Colors.white)))
                                    )
                                ),
                                title: Text(employeeList[index]["employee_name"]),
                                subtitle: Text("Salary: ${employeeList[index]["employee_salary"]}"),
                                trailing: Text("Age: ${employeeList[index]["employee_age"]}", style: TextStyle(color: Colors.blueGrey)),
                              ),
                            ),
                          );
                        },
                        itemCount: employeeList.length,
                      ),
                    );
                  }else{
                    return Container(
                        child: Center(
                            child: Text("No employees found",)
                        )
                    );
                  }
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());

              }
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}