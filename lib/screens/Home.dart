import 'package:flutter/material.dart';
import 'package:mynotes/models/TodoModel.dart';
import 'package:mynotes/services/AuthServices.dart';
import 'package:mynotes/services/NotesServices.dart';
import 'package:mynotes/widgets/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  List<TodoModel> _allData = [];
  final TextEditingController _inputController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: myAppBar(),
              body: Stack(
                children: [
                   Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    child:  Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Title(color: Colors.black, child: const Text("All TODOS",style: TextStyle(fontSize: 35),))),
                        Expanded(
                          child: FutureBuilder(
                            future: NotesServices().getAllNotes(),
                            builder: (context, snapshot) {

                              if(snapshot.hasData){
                                _allData = snapshot.data!;
                                return ListView(children: [
                                  for(TodoModel todoModel in _allData)
                                    Todo(todoModel: TodoModel(todoTopic: todoModel.todoTopic, id:todoModel.id,isDone: todoModel.isDone), onTap: (p0) => todoOnClick(todoModel.id),onDelete: (p0) => todoOnDelete(todoModel.id),),
                              ],);
                              }
                              return const Text('Loading...');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                   Align(
                    alignment: Alignment.bottomCenter,
                    child:  Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child:  Row(
                        children: [
                          Expanded(child: TextField(
                            controller: _inputController,
                            decoration: const InputDecoration(
                              hintText: 'Todo to Add',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10)
                            ),
                          )),
                          IconButton(onPressed: () => addNote(_inputController.text.trim()), icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                  )
                ],
                
              )
            );
  }

  PreferredSize myAppBar() {
    return PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                
                title: const Text('App bar'),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/image.jpg',)),
                  ),
                  IconButton(
                  onPressed: () {
                    AuthServices().logout();
                  },
                  icon: const Icon(Icons.logout),),
                ],
              ),
            );
  }
  
  addNote(String s) async {
    TodoModel todo = await NotesServices().addTodo(s);
    setState(() {
      _allData.add(todo);
    });
    _inputController.clear();
  }

  todoOnClick(String id) async{
    await NotesServices().todoOnClickToggle(id);
    setState(() {
      int index = _allData.indexWhere((element) => element.id == id);
      bool val = _allData[index].isDone;
      _allData[index].isDone = val?false:true;
    });
  }

  todoOnDelete(String id) async{
  bool delete = false;
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("AlertDialog"),
    content: const Text("Would you like to delte this Todo ?"),
    actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
        delete=false;
      }, child: const Text("Cancel")),
      TextButton(onPressed: (){
        delete=true;
        Navigator.of(context).pop();
      }, child: const Text("Delete")),
    ],
  );
  // show the dialog
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  if(!delete) {
    
    return ;
  }
    await NotesServices().todoOndelete(id);
    setState(() {
      int index = _allData.indexWhere((element) => element.id == id);
      _allData.removeAt(index);
    });
  }

}