import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqflite/controller/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit()
      : super(
          InitialTodoState(),
        );

  // todo 2
  static TodoCubit get(context) => BlocProvider.of(context);

  // todo 3
  Database? database;

  // todo 4 (finish)
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
}
