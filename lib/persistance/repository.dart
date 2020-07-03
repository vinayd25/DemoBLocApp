import 'api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<List<dynamic>> fetchEmployeeList() => appApiProvider.fetchEmployeeData();
}
