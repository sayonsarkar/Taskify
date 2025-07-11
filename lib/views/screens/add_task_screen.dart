import 'package:flutter/material.dart';
import 'package:local_data_app/models/task.dart';
import 'package:local_data_app/providers/task_provider.dart';
import 'package:local_data_app/utils/constants.dart';
import 'package:local_data_app/views/widgets/task_form_fields.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? AppConstants.addTaskTitle : 'Edit Task',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TaskFormFields(
              formKey: _formKey,
              titleController: _titleController,
              descriptionController: _descriptionController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSave,
              child: const Text(AppConstants.saveTaskButton),
            ),
          ],
        ),
      ),
    );
  }

  _handleSave() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.task?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        isCompleted: widget.task?.isCompleted ?? false,
      );
      context.read<TaskProvider>().saveTask(task);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
