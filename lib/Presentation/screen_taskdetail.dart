import 'package:flutter/material.dart';
import 'package:todo/model/taskmodel.dart'; // Ensure the path is correct

class ScreenTaskDetail extends StatefulWidget {
  final Taskmodel task;

  const ScreenTaskDetail({super.key, required this.task});

  @override
  State<ScreenTaskDetail> createState() => _ScreenTaskDetailState();
}

class _ScreenTaskDetailState extends State<ScreenTaskDetail> {
  @override
  Widget build(BuildContext context) {
    String readableStatus =
        widget.task.todoStatus == '0' ? 'Not Completed' : 'Completed';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.todoName),
        backgroundColor: const Color.fromARGB(255, 180, 162, 210),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Name:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.task.todoName,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Text(
              "Task ID:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.task.todoId,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Text(
              "Status:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              readableStatus,
              style: TextStyle(
                fontSize: 18,
                color: readableStatus == 'Completed' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
