import 'dart:convert';
import 'package:http/http.dart' show Client;

class ApiProvider{

  Client client = Client();

  final _baseUrl = "http://dummy.restapiexample.com/api/v1/employees";

  Future<List<dynamic>> fetchEmployeeData() async{

    final response = await client.get("$_baseUrl");
    print("API response: ${response.body}");
    List<dynamic> employeeList = [];

    if(response.statusCode == 200){

      Map<String, dynamic> mappedData = jsonDecode(response.body);

      if(mappedData["status"] == "success")
        employeeList = mappedData["data"] ?? [];

      return employeeList;

    }else{
      throw Exception('Failed to load data');
    }

  }

}
