import 'package:demoblocapp/persistance/repository.dart';
import 'package:rxdart/rxdart.dart';

/*BLoc class*/
class EmployeeBloc {

  Repository _repository = Repository();

  final _employeeFetcher = PublishSubject<List<dynamic>>();

  Observable<List<dynamic>> get employee => _employeeFetcher.stream;

  fetchEmployeeRecords() async {
    List<dynamic> employeeResponse = await _repository.fetchEmployeeList();
    _employeeFetcher.sink.add(employeeResponse);

  }

  dispose() {
    _employeeFetcher.close();
  }

}

final employeeBloc = EmployeeBloc();