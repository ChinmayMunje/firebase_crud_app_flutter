import 'package:flutter/material.dart';

import 'add_new_course.dart';
import 'courses_list.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: Text('Courses'),backgroundColor: Colors.white30,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewCourse(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: CourseList(),
    );
  }
}
