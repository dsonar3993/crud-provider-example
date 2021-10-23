import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:crud_provider/model/student.dart';

class StudentNotifier extends ChangeNotifier {
  List<Student> _studentList = [];
  UnmodifiableListView<Student> get studentList =>
      UnmodifiableListView(_studentList);

  addStudent(Student student) {
    _studentList.add(student);
    notifyListeners();
  }

  deleteStudent(index) {
    _studentList
        .removeWhere((_student) => _student.name == studentList[index].name);
    notifyListeners();
  }

  updateStudent(Student student, int index) {
    _studentList.removeAt(index);
    _studentList.insert(index, student);
    notifyListeners();
  }
}
