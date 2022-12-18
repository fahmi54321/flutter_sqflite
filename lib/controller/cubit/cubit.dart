import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqflite/controller/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit()
      : super(
          InitialTodoState(),
        );

  static TodoCubit get(context) => BlocProvider.of(context);

  Database? database;

  void createDatabase() {
    // path here is the file name
    // db = DataBase
    openDatabase('todo.db', version: 1, onCreate: (db, version) {
      // here our database is create (only for the first time)
      // if we don't the path file name
      log('the database is created');
      database
          ?.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT)')
          .then(
        (value) {
          // here the table is created
          log('our table is created');
        },
      ).catchError(
        (error) {
          // here is an error when creating our table
          log('an error when creating the table');
        },
      );
    }, onOpen: (db) {
      log('database file is opened');
    }).then(
      (value) {
        // the database file is succeed to open
        database = value;
        emit(
          CreateTodoDatabaseState(),
        );
      },
    ).catchError((error) {
      log('error when opening the file');
    });
  }

  void insertToDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
  }) {
    database?.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title,date,time,description) VALUES("$title","$date","$time","$description")',
      )
          .then((value) {
        log('$value');
        emit(InsertingIntoTodoDatabaseState());
      }).catchError((error) {
        log('an error when inserting into database');
      });
    });
  }

  void gettingDataFromDatabase() {
    database?.rawQuery('SELECT * FROM tasks').then((value) {
      log('our data is appearing');
      log('$value');
      emit(SuccesGettingDataFromTodoDatabaseState());
    }).catchError((error) {
      log('an error when getting data from database ${error.toString()}');
    });
  }

  // todo 1 (finish)
  void updateDataFromDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
    required String id,
  }) {
    database
        ?.update(
      'tasks',
      {
        'title': title,
        'date': date,
        'time': time,
        'description': description,
      },
      where: 'id =?',
      whereArgs: [id],
    )
        .then((value) {
      log('updating data has successfully happened $value');
      gettingDataFromDatabase();
    }).catchError((error) {
      log('error when updating data $error');
    });
  }
}
