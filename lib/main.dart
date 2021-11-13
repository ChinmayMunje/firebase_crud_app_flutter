import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud_app_flutter/Rest_API.dart';
import 'package:firebase_crud_app_flutter/facebook_authentication/facebook_auth.dart';
import 'package:firebase_crud_app_flutter/sqlite_crud/course_list_page.dart';
import 'package:flutter/material.dart';

import 'firebase_crud_pages/course_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     // CHeck for Errors
    //     if (snapshot.hasError) {
    //       print("Something went Wrong");
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return MaterialApp(
    //         title: 'Flutter Firestore CRUD',
    //         debugShowCheckedModeBanner: false,
    //         home: CourseListPage(),
    //       );
    //     }
    //     return CircularProgressIndicator();
    //   },
    // );
      return MaterialApp(
        title: 'Flutter Facebook Auth',
        debugShowCheckedModeBanner: false,
       // home: FacebookAuth(),
        home: SQLiteHomePage(),
      );

  }
}

class SQLiteHomePage extends StatelessWidget {
  const SQLiteHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sqlite CRUD",
      home: SQLCourseListPage(),
    );
  }
}

