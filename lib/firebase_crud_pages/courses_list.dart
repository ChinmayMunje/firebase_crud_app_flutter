import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app_flutter/firebase_crud_pages/update_delete_course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final Stream<QuerySnapshot> coursesStream =
      FirebaseFirestore.instance.collection('courses').snapshots();

  // For Deleting User
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  Future<void> deleteCourse(id) {
    return courses
        .doc(id)
        .delete()
        .then((value) => print('Course Deleted'))
        .catchError((error) => print('Failed to Delete course: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: coursesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            child: ListView.builder(
                itemCount: storedocs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateCoursePage(
                              id: storedocs[index]['id'],
                              orgCourseName: storedocs[index]['courseName'],
                              orgCourseImg: storedocs[index]['courseImg'],
                              orgCourseDesc: storedocs[index]['courseDesc'],
                              orgCoursePrice: storedocs[index]['coursePrice'],
                              orgCourseDuration: storedocs[index]['courseDuration'],
                              orgCourseLink: storedocs[index]['courseLink']),
                        ),
                      );
                    },
                    child: DataCard(
                      courseName: storedocs[index]['courseName'],
                      courseImg: storedocs[index]['courseImg'],
                      courseDesc: storedocs[index]['courseDesc'],
                      coursePrice: storedocs[index]['coursePrice'],
                      courseDuration: storedocs[index]['courseDuration'],
                      courseLink: storedocs[index]['courseLink'],
                    ),
                  );
                }),
          );
        });
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
                  child: Image.network(courseImg,height: 100,width: 100,),
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
                    // SizedBox(
                    //   height: 3,
                    // ),
                    // Container(
                    //   width: 210,
                    //   child: Text(courseDesc,
                    //       maxLines: 3,
                    //       style: TextStyle(fontSize: 12, color: Colors.white),
                    //       textAlign: TextAlign.start),
                    // ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //   height: 4,
            // ),
            // SizedBox(
            //   height: 3,
            // ),
            Container(
                width: 400,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black45),
                    onPressed: () {
                      //const url = 'https://flutter.io';
                      //if (canLaunch(url) != null) {
                      launch(courseLink);
                      //} else {
                      //throw 'Could not launch $url';
                      //}
                    },
                    child: Text("Enroll Now"))),
          ],
        ),

      ),
    );
  }
}
