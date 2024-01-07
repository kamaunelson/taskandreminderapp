import 'package:flutter/material.dart';
import 'package:taskandreminderapp/landing.dart';
import 'package:taskandreminderapp/ReminderList.dart';
import 'package:taskandreminderapp/TaskList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task and Reminder App',
      initialRoute: '/landing',
      routes: {
         '/landing': (context) => const landing(),
        '/tasklist': (context) => const TaskList(),
        '/reminderlist': (context) => const ReminderList(),
        // '/home': (context) => const Home(),
      },
    );
  }
}
