import 'package:flutter/material.dart';
import 'package:taskandreminderapp/ReminderList.dart';
import 'package:taskandreminderapp/TaskList.dart';

class landing extends StatelessWidget {
  const landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Task Manager'),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to the task list screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskList()),
              );
            },
            child: const Text('Tasks List'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the reminder list screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReminderList()),
              );
            },
            child: const Text('Reminder List'),
          ),
          const WeatherWidget(),
          const MotivationalQuoteWidget(),
        ],
      ),
    );
  }
}


// Define WeatherWidget and MotivationalQuoteWidget classes here
class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual implementation to fetch weather data
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: const Text(
        'Weather: Sunny, 28°C', // Replace with actual weather data
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}

class MotivationalQuoteWidget extends StatelessWidget {
  const MotivationalQuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual implementation to fetch motivational quotes
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: const Text(
        '"Your limitation—it\'s only your imagination."', // Replace with actual quote
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
