import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        courseName TEXT,
        courseImg TEXT,
        courseDuration TEXT,
        coursePrice TEXT,
        courseLink TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'gfgCourses.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new course
  static Future<int> addNewCourse(String courseName, String courseImg,
      String courseDuration, String coursePrice, String courseLink) async {
    final db = await SQLHelper.db();

    final data = {
      'courseName': courseName,
      'courseImg': courseImg,
      'courseDuration': courseDuration,
      'coursePrice': coursePrice,
      'courseLink': courseLink
    };
    final id = await db.insert('courses', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all courses
  static Future<List<Map<String, dynamic>>> getAllCourses() async {
    final db = await SQLHelper.db();
    return db.query('courses', orderBy: "id");
  }

  // Update an item by id
  static Future<int> updateCourse(int id, String courseName, String courseImg,
      String courseDuration, String coursePrice, String courseLink) async {
    final db = await SQLHelper.db();

    final data = {
      'courseName': courseName,
      'courseImg': courseImg,
      'courseDuration': courseDuration,
      'coursePrice': coursePrice,
      'courseLink': courseLink,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('courses', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteCourse(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("courses", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a course: $err");
    }
  }

// // Read a single item by id
// static Future<List<Map<String, dynamic>>> getCourseById(int id) async {
//   final db = await SQLHelper.db();
//   return db.query('courses', where: "id = ?", whereArgs: [id], limit: 1);
// }
}
