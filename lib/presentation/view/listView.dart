import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/business_logic/cubit/cubit.dart';
import 'package:to_do_list/business_logic/cubit/states.dart';

import '../widgets/listView_item.dart';

class ListViewView extends StatelessWidget {
  var model;
  ListViewView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.length > 0
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => ListViewItem(model: model[index]),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10.0,
                ),
            itemCount: model.length)
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 100,
                  color: Colors.grey[500],
                ),
                Text('No Tasks Yet,Please Add Some Tasks',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18, color: Colors.grey[500])),
              ],
            ),
          );
  }
}
