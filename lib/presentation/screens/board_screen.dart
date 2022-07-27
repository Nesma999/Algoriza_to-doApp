import 'package:flutter/material.dart';
import 'package:to_do_list/presentation/screens/all_tasks_screen.dart';
import 'package:to_do_list/presentation/screens/favorite_screen.dart';
import 'package:to_do_list/presentation/screens/schedule_screen.dart';
import 'package:to_do_list/presentation/screens/uncompleted_screen.dart';

import '../widgets/myButton.dart';
import 'add_task_screen.dart';
import 'completed_screen.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Board',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 22),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScheduleScreen()));
                },
                icon: const Icon(Icons.calendar_month_outlined)),
          ],
        ),
        body: Column(
          children: [
            const Divider(color: Colors.grey),
            const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                  Tab(
                    text: 'Uncompleted',
                  ),
                  Tab(
                    text: 'Favorite',
                  ),
                ]),
            const Divider(color: Colors.grey),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TabBarView(children: [
                  AllTasksScreen(),
                  CompletedScreen(),
                  UncompletedScreen(),
                  FavoriteScreen(),
                ]),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: MyButton(
                  text: 'Add Task',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTaskScreen()));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
