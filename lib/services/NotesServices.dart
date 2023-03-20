import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/services/AuthServices.dart';

import '../models/TodoModel.dart';

class NotesServices{

  User? currentUser = AuthServices().user;
  CollectionReference<Map<String, dynamic>> database = FirebaseFirestore.instance.collection('todos');


  Future<List<TodoModel>> getAllNotes() async {
    //TODO add user field that refers to each id user to know the owner of each todo
    List<TodoModel> list = [];
    final QuerySnapshot result = await database.get();
    final List<DocumentSnapshot> documents = result.docs;
    for (var data in documents) {
      dynamic objet = data.data();
      print(objet);
      list.add(TodoModel(todoTopic: objet['todo_content'], id: data.reference.id,isDone: objet['done']));
      print("stuck here ?");
    }
    return list;
  }

  Future<TodoModel> addTodo(String text) async {
    String id = Timestamp.now().millisecondsSinceEpoch.toString();
    TodoModel todo = TodoModel(todoTopic: text, id: id);
    await database.doc(id).set({
      'user':currentUser?.uid,
      'todo_content':text,
      'done':false
    });
    return todo;
  }

  Future<void> todoOnClickToggle(String id) async{
    bool val = true;
    await database.doc(id).get().then((value){
      val = value.data()?['done'];
    });
    await database.doc(id).update({
      'done':val?false:true
    });
  }

  todoOndelete(String id) async {
    await database.doc(id).delete();
  }

}