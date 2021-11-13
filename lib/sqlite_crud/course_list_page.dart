import 'package:firebase_crud_app_flutter/sqlite_crud/add_new_course.dart';
import 'package:firebase_crud_app_flutter/sqlite_crud/sqlite_helper.dart';
import 'package:firebase_crud_app_flutter/sqlite_crud/update_delete_course.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SQLCourseListPage extends StatefulWidget {
  const SQLCourseListPage({Key key}) : super(key: key);

  @override
  _SQLCourseListPageState createState() => _SQLCourseListPageState();
}

class _SQLCourseListPageState extends State<SQLCourseListPage> {
  List<Map<String, dynamic>> allCourses = [];
  bool isLoading = true;

  void refreshCourses() async {
    final data = await SQLHelper.getAllCourses();
    setState(() {
      allCourses = data;
      isLoading = false;
    });
    setState(() {
      if (allCourses.isEmpty) isLoading = true;
    });
  }

  @override
  void initState() {
      refreshCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshCourses();
    });
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Colors.white30,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SQLAddNewCourse(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allCourses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCourseSQLitePage(
                            id: allCourses[index]['id'],
                            orgCourseName: allCourses[index]['courseName'],
                            orgCourseImg: allCourses[index]['courseImg'],
                            orgCourseDesc: "courseDesc",
                            orgCoursePrice: allCourses[index]['coursePrice'],
                            orgCourseDuration: allCourses[index]
                                ['courseDuration'],
                            orgCourseLink: allCourses[index]['courseLink']),
                      ),
                    );
                  },
                  child: DataCard(
                    courseName: allCourses[index]['courseName'],
                    courseImg: allCourses[index]['courseImg'],
                    courseDesc: "courseDesc",
                    coursePrice: allCourses[index]['coursePrice'],
                    courseDuration: allCourses[index]['courseDuration'],
                    courseLink: allCourses[index]['courseLink'],
                  ),
                );
              }),
    );
  }
}


class DataCard extends StatelessWidget {
  final String courseName,
      courseImg,
      courseDesc,
      coursePrice,
      courseDuration,
      courseLink;

  DataCard(
      {this.courseName,
      this.courseImg,
      this.courseDesc,
      this.coursePrice,
      this.courseDuration,
      this.courseLink});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white24,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                    courseImg,
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Course Duration : " + courseDuration,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Course Price : " + coursePrice,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            Container(
                width: 400,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black45),
                    onPressed: () {
                      launch(courseLink);
                    },
                    child: Text("Enroll Now"))),
          ],
        ),
      ),
    );
  }
}
