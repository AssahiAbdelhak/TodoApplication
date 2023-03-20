import 'package:flutter/material.dart';
import 'package:mynotes/models/TodoModel.dart';

class Todo extends StatelessWidget {
  final TodoModel todoModel;
  final Function(String) onDelete;
  final Function(String) onTap;
  const Todo({super.key, required this.todoModel,required this.onTap,required this.onDelete});
  
  @override
  Widget build(BuildContext context) {
    if(todoModel.isDone)
      print("checked box");
    return Container(
      margin:const  EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: todoModel.isDone?const Icon(Icons.check_box):const Icon(Icons.check_box_outline_blank),
        title: Text(todoModel.todoTopic),
        onTap: () => onTap(todoModel.id)
        ,
        trailing: Container(
          decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(12)),
          child: IconButton(icon: const Icon(Icons.delete,color: Colors.white,),
          onPressed: () {
            onDelete(todoModel.id);
          },),
        ),
      ),
    );
  }
}