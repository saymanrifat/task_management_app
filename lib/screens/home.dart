import 'package:flutter/material.dart';

import '../controller/tf_controller.dart';
import '../model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> myTask = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Management')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {
              showBottomSheet(context, index);
            },
            title: Text(myTask[index].title),
            trailing: Text(myTask[index].dateTime),
            subtitle: Text(myTask[index].description),
          );
        },
        itemCount: myTask.length,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialogBox(context);
        },
        label: const Text('New Task'),
      ),
    );
  }

  showDialogBox(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  myTask.add(Task(
                      Controller.addTitleController.text,
                      Controller.addDescriptionController.text,
                      Controller.dateController.text.toString()));
                  cleaningController();
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text('Save')),
          ],
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                const Text('Add Task'),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: Controller.addTitleController,
                  decoration: const InputDecoration(
                      label: Text('Title'), border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: Controller.addDescriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Deadline"),
                      border: OutlineInputBorder(),
                    ),
                    controller: Controller.dateController,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  cleaningController() {
    Controller.addTitleController.clear();
    Controller.addDescriptionController.clear();
    Controller.dateController.clear();
  }

  showBottomSheet(context, index) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(12),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Details',
                style: TextStyle(fontSize: 20),
              ),
              Text("Title: ${myTask[index].title}"),
              Text("Desc: ${myTask[index].description}"),
              Text("By ${myTask[index].dateTime}"),
              ElevatedButton(
                  onPressed: () {
                    myTask.removeAt(index);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Deleted')));
                    setState(() {});
                  },
                  child: Text('Delete')),
            ],
          ),
        );
      },
    );
  }
}
