import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/business_logic/cubit/cubit.dart';
import 'package:to_do_list/business_logic/cubit/states.dart';
import 'package:to_do_list/services/notification_service.dart';

import '../widgets/Schedule_list_item.dart';
import '../widgets/listColors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                NotificationService().displayNotification(
                    title: 'Change Theme',
                    body: 'body'
                );
              },
              icon: Icon(Icons.label_important_outline),
            ),
            title: Text(
              'Schedule',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 22),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.green,
                    selectedTextColor: Colors.white,
                    daysCount: 7,
                    dateTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                    onDateChange: (date) {
                      setState(() {
                        _selectedValue = date;
                      });
                    },
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat.EEEE().format(_selectedValue)),
                          Text(DateFormat.yMMMd().format(_selectedValue))
                        ],
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => cubit.allTasks[index]
                                ['date'] ==
                            DateFormat.yMMMd().format(_selectedValue)
                        ? ScheduleListItem(
                            model: cubit.allTasks[index],
                          )
                        : Container(),
                    itemCount: cubit.allTasks.length)
              ],
            ),
          ),
        );
      },
    );
  }
}
