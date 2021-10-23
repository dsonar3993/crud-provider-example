import 'package:crud_provider/controller/student_notifier.dart';
import 'package:crud_provider/model/student.dart';
import 'package:crud_provider/widget/widget_button.dart';
import 'package:crud_provider/widget/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String _name;
  String _city;
  int _pointer;
  bool editMode = false;
  List<Student> userList = [];

  editUser(Student user, int index) {
    setState(() {
      nameController.text = user.name;
      cityController.text = user.address;
      _pointer = index;
      editMode = true;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  FocusNode namefn = FocusNode();
  FocusNode cityfn = FocusNode();

  @override
  Widget build(BuildContext context) {
    StudentNotifier studentNotifier = Provider.of<StudentNotifier>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "CRUD Provider Example",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WidgetTextField(
                labelText: 'Name',
                textEditingController: nameController,
                focusNode: namefn,
                onSaved: (String value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16),
              WidgetTextField(
                labelText: 'Address',
                textEditingController: cityController,
                focusNode: cityfn,
                onSaved: (String value) {
                  _city = value;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  studentNotifier.studentList.isNotEmpty && editMode == true
                      ? Consumer<StudentNotifier>(
                          builder: (_, notifier, __) => WidgetButton(
                            text: 'Update',
                            color: Colors.deepPurple,
                            onPressed: () {
                              studentNotifier.updateStudent(
                                  Student(
                                      nameController.text, cityController.text),
                                  _pointer);
                              nameController.clear();
                              cityController.clear();
                              namefn.requestFocus();
                              setState(() {
                                editMode = false;
                              });
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Card(
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<StudentNotifier>(
                                builder: (_, notifier, __) => Text(
                                      'Name: ${notifier.studentList[index].name}',
                                      style: TextStyle(fontSize: 20),
                                    )),
                            Consumer<StudentNotifier>(
                                builder: (_, notifier, __) => Text(
                                      'Address: ${notifier.studentList[index].address}',
                                      style: TextStyle(fontSize: 20),
                                    )),
                          ],
                        ),
                        Row(
                          children: [
                            Consumer<StudentNotifier>(
                              builder: (_, notifier, __) => IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => editUser(
                                    studentNotifier.studentList[index], index),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Confirmation',
                                        ),
                                        content: Stack(
                                          children: [
                                            Text(
                                              'Are you sure you want to Delete?',
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'),
                                          ),
                                          Consumer<StudentNotifier>(
                                            builder: (_, notifier, __) =>
                                                TextButton(
                                              onPressed: () {
                                                studentNotifier
                                                    .deleteStudent(index);
                                                //deleteUser(userList[index]);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: studentNotifier.studentList.length,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(' + Add Student '),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          if (!_formKey.currentState.validate()) return;
          _formKey.currentState.save();
          studentNotifier.addStudent(Student(_name, _city));
          nameController.clear();
          cityController.clear();
          //addUser(Student(_name, _city));
        },
      ),
    );
  }
}
