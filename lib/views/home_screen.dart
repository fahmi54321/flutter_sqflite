import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqflite/controller/cubit/cubit.dart';
import 'package:flutter_sqflite/controller/cubit/states.dart';
import 'package:flutter_sqflite/views/add_task_screen.dart';
import 'package:flutter_sqflite/views/drawer_screen.dart';
import 'package:flutter_sqflite/views/update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          final cubit = TodoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('My task'.tr()),
              elevation: 1,
              backgroundColor: Colors.deepOrange.shade200,
            ),
            drawer: const Drawer(
              child: DrawerScreen(),
            ),
            body: ListView.builder(
              itemCount: cubit.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return UpdateTaskScreen(id: 1);
                    }));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.tasks[index]['title'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                cubit.tasks[index]['time'],
                                style: Theme.of(context).textTheme.caption,
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.deleteDataFromDatabase(
                                      id: cubit.tasks[index]['id'],
                                    );
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                          Text(
                            cubit.tasks[index]['description'],
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AddTaskScreen();
                }));
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
