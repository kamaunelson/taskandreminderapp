import 'package:flutter/material.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

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
  const ReminderList({Key? key}) : super(key: key);

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

  void _showUpdateReminderDialog(Reminder reminder) {
    // Similar to _showAddReminderDialog, with pre-filled fields for the selected reminder
    // Implement code here for updating reminders
    // You can use similar logic for updating reminders as used in the _showAddReminderDialog
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
                return ListTile(
                  title: Text(reminders[index].name),
                  subtitle: Text(
                    'Time: ${reminders[index].dateTime.hour}:${reminders[index].dateTime.minute} - ${reminders[index].category}',
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
                    // Perform update on tap
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
                // Implement edit functionality
                // Call _showUpdateReminderDialog for selected reminders
                // Use reminders.where((reminder) => reminder.isSelected).toList() to get selected reminders
              },
            ),
          ],
        ),
      ),
    );
  }
}
