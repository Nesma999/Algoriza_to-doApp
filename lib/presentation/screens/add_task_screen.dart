import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/business_logic/cubit/cubit.dart';
import 'package:to_do_list/business_logic/cubit/states.dart';
import 'package:to_do_list/presentation/widgets/myButton.dart';
import 'package:to_do_list/services/notification_service.dart';

import '../widgets/myTextField.dart';
import 'board_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var reminderController = TextEditingController();
  var repeatController = TextEditingController();
  int dropdownValue = 10;
  String repeatDropdownValue = 'None';
  var initialTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppDatabaseInserted) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BoardScreen()));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Task',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 22),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MyTextField(
                          controller: cubit.titleController,
                          hintText: 'Task',
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Deadline',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MyTextField(
                            readOnly: true,
                            showCursor: false,
                            controller: cubit.dateController,
                            hintText: '2021-04-20',
                            keyboardType: TextInputType.datetime,
                            suffixIcon: IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2032-12-30'),
                                ).then((value) {
                                  cubit.dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                }).catchError((error) {
                                  print('${error.toString()}');
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.grey,
                              ),
                            )),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start time',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  MyTextField(
                                    readOnly: true,
                                    showCursor: false,
                                    controller: cubit.startTimeController,
                                    keyboardType: TextInputType.datetime,
                                    hintText: TimeOfDay.now()
                                        .format(context)
                                        .toString(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.access_time,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: initialTime,
                                        ).then((value) {
                                          cubit.startTimeController.text =
                                              value!.format(context).toString();
                                        }).catchError((error) {
                                          print('${error.toString()}');
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End time',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  MyTextField(
                                    readOnly: true,
                                    showCursor: false,
                                    controller: cubit.endTimeController,
                                    keyboardType: TextInputType.datetime,
                                    hintText: TimeOfDay.now()
                                        .format(context)
                                        .toString(),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            cubit.endTimeController.text =
                                                value!
                                                    .format(context)
                                                    .toString();
                                          }).catchError((error) {
                                            print('${error.toString()}');
                                          });
                                        },
                                        icon: Icon(
                                          Icons.access_time,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Remind',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MyTextField(
                          readOnly: true,
                          showCursor: false,
                          controller: reminderController,
                          hintText: '$dropdownValue minutes early',
                          keyboardType: TextInputType.text,
                          suffixIcon: PopupMenuButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.grey,
                              ),
                              onSelected: (int? newValue) {
                                setState(() {
                                  reminderController.text = newValue.toString();
                                });
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 10,
                                      child: Text('10 minutes'),
                                      onTap: () {
                                        NotificationService().scheduleNotification(
                                            10,
                                            'Task ${cubit.titleController.text}',
                                            'Remind To Complete Task ${cubit.titleController.text}',
                                            minutes: 1,
                                            hours: 0,
                                            days: 0);
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: 30,
                                      child: Text('30 minutes'),
                                      onTap: () {
                                        NotificationService().scheduleNotification(
                                            30,
                                            'Task ${cubit.titleController.text}',
                                            'Remind To Complete Task ${cubit.titleController.text}',
                                            minutes: 30,
                                            hours: 0,
                                            days: 0);
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text('1 hour'),
                                      onTap: () {
                                        NotificationService().scheduleNotification(
                                            1,
                                            'Task ${cubit.titleController.text}',
                                            'Remind To Complete Task ${cubit.titleController.text}',
                                            minutes: 0,
                                            hours: 1,
                                            days: 0);
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text('1 day'),
                                      onTap: () {
                                        NotificationService().scheduleNotification(
                                            1,
                                            'Task ${cubit.titleController.text}',
                                            'Remind To Complete Task ${cubit.titleController.text}',
                                            minutes: 0,
                                            hours: 0,
                                            days: 1);
                                      },
                                    ),
                                  ]),
                          // DropdownButton<int>(
                          //   underline: Container(
                          //     height: 0,
                          //   ),
                          //   icon: const Icon(
                          //     Icons.keyboard_arrow_down_outlined,
                          //     color: Colors.grey,
                          //   ),
                          //   onChanged: (int? newValue) {
                          //     setState(() {
                          //       reminderController.text = newValue.toString();
                          //     });
                          //   },
                          //   items: <int>[
                          //     10,
                          //     30,
                          //     1,
                          //     1
                          //   ].map<DropdownMenuItem<int>>((int value) {
                          //     return DropdownMenuItem<int>(
                          //       value: value,
                          //       child: Text('$value'),
                          //       onTap: () {
                          //         //print(int.parse(cubit.startTimeController.text.split(":")[1].split(" ")[0])+1,);
                          //         NotificationService().scheduleNotification(
                          //           value,
                          //             'Task ${cubit.titleController.text}',
                          //           'Remind To Complete Task ${cubit.titleController.text}',
                          //         );
                          //             //int.parse(minutes));
                          //       },
                          //     );
                          //   }).toList(),
                          // ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Repeat',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MyTextField(
                          readOnly: true,
                          showCursor: false,
                          controller: repeatController,
                          hintText: repeatDropdownValue,
                          keyboardType: TextInputType.text,
                          suffixIcon: DropdownButton<String>(
                            underline: Container(
                              height: 0,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                repeatController.text = newValue!;
                              });
                            },
                            items: <String>[
                              'None',
                              'Daily',
                              'Weekly',
                              'Monthly'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text('Colors'),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        cubit.selectedColor = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: index == 0
                                          ? Colors.blue
                                          : index == 1
                                              ? Colors.red
                                              : index == 2
                                                  ? Colors.teal
                                                  : index == 3
                                                      ? Colors.purpleAccent
                                                      : Colors.amber,
                                      child: cubit.selectedColor == index
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : Container(),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 5,
                                ),
                                itemCount: 5,
                              ),
                            ),
                            Spacer(),
                            MyButton(
                                text: 'Create Task',
                                width: 120,
                                onPressed: () {
                                  cubit.insertUserData();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
