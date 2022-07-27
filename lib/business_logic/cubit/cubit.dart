import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/business_logic/cubit/states.dart';
import 'package:path/path.dart' as p;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'to-doApp.db');

    print('AppDatabaseInitialized');

    openAppDatabase(
      path: path,
    );

    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({
    required String path,
  }) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db
            .execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,startTime TEXT,endTime TEXT,status TEXT,color INTEGER )',
        )
            .then((value) {
          print('Table Created');
        }).catchError((onError) {
          print('error when create table ${onError.toString()}');
        });
      },
      onOpen: (Database db) {
        print('AppDatabaseOpened');
        database = db;
        getUsersData();
      },
    );
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  int selectedColor = 0;
  void insertUserData() {
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Tasks(title,date,startTime,endTime,status,color) VALUES("${titleController.text}","${dateController.text}","${startTimeController.text}","${endTimeController.text}","new","$selectedColor")');
    }).then((value) {
      debugPrint('User Data Inserted');
      titleController.clear();
      dateController.clear();
      startTimeController.clear();
      endTimeController.clear();
      getUsersData();
      emit(AppDatabaseInserted());
    });
  }

  var allTasks = [];
  var newTasks = [];
  var completeTasks = [];
  var favoriteTasks = [];
  void getUsersData() async {
    emit(AppDatabaseGetLoading());
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      newTasks = [];
      completeTasks = [];
      favoriteTasks = [];
      allTasks = value;
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          completeTasks.add(element);
        } else if (element['status'] == 'favorite') {
          favoriteTasks.add(element);
        }
      });
      debugPrint('Get Tasks Successfully');
      emit(AppDatabaseGetTasks());
    }).catchError((error) {
      debugPrint('error when insert ${error.toString()}');
    });
    ;
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE Tasks SET status=? WHERE ID=?', ['$status', id]).then((value) {
      print('Updated Successfully');
      getUsersData();
      emit(AppUpdateDatabaseState());
    }).catchError((error) {
      print('When Update Found Error${error.toString()}');
    });
  }

  void deleteDataFromDatabase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      print('Record Deleted Successfully');
      getUsersData();
      emit(AppDeleteDatabaseState());
    }).catchError((erorr) {
      print('Error Found When Delete ${erorr.toString()}');
    });
  }
}
