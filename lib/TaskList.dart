import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  Future<void> _showAddTaskDialog() async {
    String taskName = '';
    String taskDate = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
                onChanged: (value) {
                  taskName = value;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                ),
                onChanged: (value) {
                  taskDate = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (taskName.isNotEmpty && taskDate.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(
                      title: taskName,
                      date: taskDate,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUpdateTaskDialog(Task task) async {
    String updatedTaskName = task.title;
    String updatedTaskDate = task.date;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
                controller: TextEditingController(text: updatedTaskName),
                onChanged: (value) {
                  updatedTaskName = value;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                ),
                controller: TextEditingController(text: updatedTaskDate),
                onChanged: (value) {
                  updatedTaskDate = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  task.title = updatedTaskName;
                  task.date = updatedTaskDate;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Update Task'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(Task task) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.remove(task);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Task Page'),
        ),
      ),
      body: itemCount == 0
          ? Center(
              child: Text('No tasks yet.'),
            )
          : ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return TaskListItem(
                  task: tasks[index],
                  onCheckboxChanged: (isChecked) {
                    setState(() {
                      tasks[index].isCompleted = isChecked ?? false;

                      if (tasks[index].isCompleted) {
                        _showUpdateTaskDialog(tasks[index]);
                      }
                    });
                  },
                  onDeletePressed: () {
                    _showDeleteConfirmationDialog(tasks[index]);
                  },
                  onUpdatePressed: () {
                    _showUpdateTaskDialog(tasks[index]);
                  },
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.update),
              onPressed: () {
                tasks.forEach((task) {
                  if (task.isCompleted) {
                    _showUpdateTaskDialog(task);
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                tasks.forEach((task) {
                  if (task.isCompleted) {
                    _showDeleteConfirmationDialog(task);
                  }
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddTaskDialog();
        },
      ),
    );
  }
}

class Task {
  String title;
  String date;
  bool isCompleted;

  Task({
    required this.title,
    required this.date,
    this.isCompleted = false,
  });
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onDeletePressed;
  final VoidCallback onUpdatePressed;

  TaskListItem({
    required this.task,
    required this.onCheckboxChanged,
    required this.onDeletePressed,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.date),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: onCheckboxChanged,
      ),
      // onTap: () {
      //   onUpdatePressed();
      // },
      onLongPress: () {
        onDeletePressed();
      },
    );
  }
}
