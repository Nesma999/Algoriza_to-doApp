import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/business_logic/cubit/cubit.dart';
import 'package:to_do_list/business_logic/cubit/states.dart';

import 'listColors.dart';

class ScheduleListItem extends StatelessWidget {
  final Map model;
  const ScheduleListItem({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultColor(model['color']),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model['startTime'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              model['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        const Spacer(),
                        model['status'] == 'done'
                            ? const Icon(
                                Icons.task_alt,
                                color: Colors.white,
                              )
                            : const Icon(Icons.radio_button_unchecked,
                                color: Colors.white),
                      ],
                    ),
                  ),
                ),
              );
  }
}
