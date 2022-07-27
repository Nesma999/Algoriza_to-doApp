import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list/business_logic/cubit/cubit.dart';
import 'package:to_do_list/business_logic/cubit/states.dart';

import 'listColors.dart';

class ListViewItem extends StatefulWidget {
   var model;
    ListViewItem({
    required this.model,
    Key? key
   }) : super(key: key);

  @override
  State<ListViewItem> createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  bool isChecked = false;
  bool isCheckedDone = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){} ,
      builder:(context,state){
         var cubit=AppCubit.get(context);
        return Row(
          children: [
            Checkbox(
              value: widget.model['status']=='done' ?isCheckedDone:isChecked,
              activeColor:  defaultColor(widget.model['color']),
              side: BorderSide(
                color: defaultColor(widget.model['color'])!,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onChanged: (value) {
               setState((){
                 isChecked=value!;
               });
              },
            ),
            Expanded(
                child: Text('${widget.model['title']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.bodySmall,
                )),
            //Spacer(),
             PopupMenuButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
                itemBuilder: (context) => [

                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.task_alt),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Complete Task")
                      ],
                    ),
                    onTap: (){
                      cubit.updateData(status: 'done', id: widget.model['id']);
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: const [
                        Icon(Icons.favorite_border),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Add To Favorite")
                      ],
                    ),
                    onTap: (){
                      cubit.updateData(status: 'favorite', id: widget.model['id']);
                    },
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: const [
                        Icon(Icons.remove_circle_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Remove Task")
                      ],
                    ),
                    onTap: (){
                      cubit.deleteDataFromDatabase(id: widget.model['id']);
                    },
                  ),
                ])
          ],
        );
      } ,
    );
  }
}
