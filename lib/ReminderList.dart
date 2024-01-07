import 'package:flutter/material.dart';

class Reminder {
  String name;
  DateTime dateTime;
  String category;
  bool isSelected;

  Reminder({
    required this.name,
    required this.dateTime,
    required this.category,
    this.isSelected = false,
  });
}

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  List<Reminder> reminders = [];

  void _showAddReminderDialog() async {
  String reminderName = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedCategory = 'Low'; // Default category

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Reminder'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Reminder Name'),
                onChanged: (value) {
                  reminderName = value;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                  const SizedBox(width: 10),
                  Text(selectedDate != null
                      ? 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}'
                      : 'No Date Chosen'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 00, minute: 00),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: const Text('Select Time'),
                  ),
                  const SizedBox(width: 10),
                  Text(selectedTime != null
                      ? 'Time: ${selectedTime!.format(context)}'
                      : 'No Time Chosen'),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: <String>['Low', 'Medium', 'High'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              if (reminderName.isNotEmpty && selectedDate != null && selectedTime != null) {
                setState(() {
                  reminders.add(Reminder(
                    name: reminderName,
                    dateTime: DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    ),
                    category: selectedCategory,
                  ));
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}


  void _showUpdateReminderDialog(Reminder reminder) async {
  String updatedReminderName = reminder.name;
  DateTime? updatedSelectedDate = reminder.dateTime;
  TimeOfDay? updatedSelectedTime = TimeOfDay.fromDateTime(reminder.dateTime);
  String updatedSelectedCategory = reminder.category;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Reminder'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Reminder Name'),
                onChanged: (value) {
                  updatedReminderName = value;
                },
                controller: TextEditingController(text: updatedReminderName),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: updatedSelectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          updatedSelectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                  const SizedBox(width: 10),
                  Text(updatedSelectedDate != null
                      ? 'Date: ${updatedSelectedDate!.toLocal().toString().split(' ')[0]}'
                      : 'No Date Chosen'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: updatedSelectedTime ?? const TimeOfDay(hour: 00, minute: 00),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          updatedSelectedTime = pickedTime;
                        });
                      }
                    },
                    child: const Text('Select Time'),
                  ),
                  const SizedBox(width: 10),
                  Text(updatedSelectedTime != null
                      ? 'Time: ${updatedSelectedTime!.format(context)}'
                      : 'No Time Chosen'),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: updatedSelectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    updatedSelectedCategory = value!;
                  });
                },
                items: <String>['Low', 'Medium', 'High'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              if (updatedReminderName.isNotEmpty && updatedSelectedDate != null && updatedSelectedTime != null) {
                setState(() {
                  // Update the reminder in the list with the new values
                  reminders[reminders.indexOf(reminder)] = Reminder(
                    name: updatedReminderName,
                    dateTime: DateTime(
                      updatedSelectedDate!.year,
                      updatedSelectedDate!.month,
                      updatedSelectedDate!.day,
                      updatedSelectedTime!.hour,
                      updatedSelectedTime!.minute,
                    ),
                    category: updatedSelectedCategory,
                  );
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Update'),
          ),
        ],
      );
    },
  );
}


  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete selected reminders?'),
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
                  reminders.removeWhere((reminder) => reminder.isSelected);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder List'),
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text('No reminders yet.'),
            )
          : ListView.builder(
  itemCount: reminders.length,
  itemBuilder: (context, index) {
    String formattedDate = '${reminders[index].dateTime.year}-${reminders[index].dateTime.month.toString().padLeft(2, '0')}-${reminders[index].dateTime.day.toString().padLeft(2, '0')}';
    String formattedTime = '${reminders[index].dateTime.hour}:${reminders[index].dateTime.minute.toString().padLeft(2, '0')}';
    
    return ListTile(
      title: Text(reminders[index].name),
      subtitle: Text(
        'Date: $formattedDate | Time: $formattedTime | Category: ${reminders[index].category}',
      ),
      trailing: Checkbox(
        value: reminders[index].isSelected,
        onChanged: (bool? value) {
          setState(() {
            reminders[index].isSelected = value!;
          });
        },
      ),
      onTap: () {
        _showUpdateReminderDialog(reminders[index]);
      },
    );
  },
),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddReminderDialog();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog();
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
              // Find the index of the selected reminder
              int selectedIndex = reminders.indexWhere((reminder) => reminder.isSelected);

              if (selectedIndex != -1) {
              _showUpdateReminderDialog(reminders[selectedIndex]);
              } else {
            // Show a message if no reminder is selected
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
            content: Text('Please select a reminder to edit.'),
            ),
          );
       }
      },
     ),
          ],
        ),
      ),
    );
  }
}
