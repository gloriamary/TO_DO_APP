import 'package:flutter/material.dart';
import 'package:todo/model/taskmodel.dart';
import 'package:todo/Presentation/screen_taskdetail.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _formKey = GlobalKey<FormState>();
  final List<Taskmodel> myTask = [];
  int todoCounter = 0;
  TextEditingController todotext = TextEditingController();

  bool isEditing = false;
  int? editingIndex;

  void addToDo(Taskmodel t) {
    myTask.add(t);
  }

  void updateTask(int index, String newName) {
    myTask[index].todoName = newName;
  }

  void cancelEdit() {
    setState(() {
      isEditing = false;
      editingIndex = null;
      todotext.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'To Do App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: todotext,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " *required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter the task',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Visibility(
                            visible: !isEditing,
                            child: IconButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    todoCounter++;
                                    addToDo(Taskmodel(
                                      todoId: todoCounter.toString(),
                                      todoName: todotext.text,
                                      todoStatus: '0',
                                    ));
                                    todotext.clear();
                                  });
                                }
                              },
                              icon: const Icon(Icons.add, size: 30),
                              color: Colors.indigo,
                            ),
                          ),
                          Visibility(
                            visible: isEditing,
                            child: IconButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    editingIndex != null) {
                                  setState(() {
                                    updateTask(editingIndex!, todotext.text);
                                    isEditing = false;
                                    editingIndex = null;
                                    todotext.clear();
                                  });
                                }
                              },
                              icon: const Icon(Icons.save, color: Colors.green),
                            ),
                          ),
                          Visibility(
                            visible: isEditing,
                            child: IconButton(
                              onPressed: cancelEdit,
                              icon: const Icon(Icons.cancel, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}.',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  Text(
                                    myTask[index].todoName),
                                  GestureDetector(
  onTap: () {
    setState(() {
      myTask[index].todoStatus =
          myTask[index].todoStatus == '0' ? '1' : '0';
    });
  },
  child: Text(
    myTask[index].todoStatus == '0'
        ? 'Status: Not Completed (Tap to mark completed)'
        : 'Status: Completed (Tap to mark not completed)',
    style: TextStyle(
      color: myTask[index].todoStatus == '0'
          ? Colors.red
          : Colors.green,
      fontWeight: FontWeight.w600,
    ),
  ),
),

                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenTaskDetail(task: myTask[index]),
                                  ),
                                );
                              },
                              child: const Text("View",
                                  style: TextStyle(color: Colors.indigo)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                setState(() {
                                  isEditing = true;
                                  editingIndex = index;
                                  todotext.text = myTask[index].todoName;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  if (isEditing && editingIndex == index) {
                                    cancelEdit();
                                  }
                                  myTask.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: myTask.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
