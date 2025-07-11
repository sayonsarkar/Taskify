import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_data_app/models/task.dart';
import 'package:local_data_app/providers/task_provider.dart';
import 'package:local_data_app/utils/constants.dart';
import 'package:local_data_app/views/screens/add_task_screen.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: _buildCheckbox(context),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: _buildSubtitle(),
        trailing: _buildDeleteButton(context),
        onTap: () => _navigateToEditTask(context),
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return Checkbox(
          value: task.isCompleted,
          onChanged: (value) => taskProvider.toggleTaskStatus(task),
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.description.isNotEmpty) Text(task.description),
        Text(
          DateFormat('MMM dd, yyyy - hh:mm a').format(task.createdAt),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => _showDeleteDialog(context),
    );
  }

  void _navigateToEditTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen(task: task)),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(AppConstants.deleteConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(AppConstants.cancel),
              ),
              TextButton(
                onPressed: () {
                  context.read<TaskProvider>().deleteTask(task.id!);
                  Navigator.pop(context);
                },
                child: const Text(
                  AppConstants.delete,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
