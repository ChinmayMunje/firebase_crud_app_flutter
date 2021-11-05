import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewCourse extends StatefulWidget {
  const AddNewCourse({Key key}) : super(key: key);

  @override
  _AddNewCourseState createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  final _formKey = GlobalKey<FormState>();

  var courseName = "";
  var courseImgUrl = "";
  var courseDesc = "";
  var courseDuration = "";
  var coursePrice = "";
  var courseLink = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final courseNameController = TextEditingController();
  final courseImageController = TextEditingController();
  final courseDescController = TextEditingController();
  final courseDurationController = TextEditingController();
  final coursePriceController = TextEditingController();
  final courseLinkController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    courseNameController.dispose();
    courseImageController.dispose();
    courseDescController.dispose();
    courseDurationController.dispose();
    coursePriceController.dispose();
    courseLinkController.dispose();
    super.dispose();
  }

  clearText() {
    courseNameController.clear();
    courseImageController.clear();
    courseDescController.clear();
    courseDurationController.clear();
    coursePriceController.clear();
    courseLinkController.clear();
  }

  displayMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
    Navigator.pop(context);
  }

  // Adding Student
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  Future<void> addCourse() {
    return courses
        .add({
          'courseName': courseName,
          'courseImg': courseImgUrl,
          'courseDesc': "courseDesc",
          'courseDuration': courseDuration,
          'coursePrice': coursePrice,
          'courseLink': courseLink
        })
        .then((value) =>displayMessage('New Course Added'))
        .catchError((error) =>displayMessage('Fail to add new Course'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.white30,
        title: Text('Add new Course'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
                    labelText: 'Course Name',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: courseNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Course Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
                    labelText: 'Course Image Url',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: courseImageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Course Image URL';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     autofocus: false,
              //     style: TextStyle(color: Colors.white),
              //     decoration: InputDecoration(
              //       //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
              //       labelText: 'Course Description',
              //       labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(
              //         color: Colors.white,
              //         width: 1.0,
              //       )),
              //       enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //         color: Colors.white,
              //         width: 1.0,
              //       )),
              //       errorStyle:
              //           TextStyle(color: Colors.redAccent, fontSize: 15),
              //     ),
              //     controller: courseDescController,
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter Course Description';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
                    labelText: 'Course Duration',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: courseDurationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Course Duration';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Course Price',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: coursePriceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Course Price';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
                    labelText: 'Course Link',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: courseLinkController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Course Link';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white30),
                  onPressed: () {
                    setState(() {
                      courseName = courseNameController.text;
                      courseImgUrl = courseImageController.text;
                      courseDesc = courseDescController.text;
                      coursePrice = coursePriceController.text;
                      courseDuration = courseDurationController.text;
                      courseLink = courseLinkController.text;
                      addCourse();
                      clearText();
                    });
                  },
                  child: Text('Add Course')),
            ],
          ),
        ),
      ),
    );
  }
}
