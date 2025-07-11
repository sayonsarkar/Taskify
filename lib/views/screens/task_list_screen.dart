import 'package:flutter/material.dart';
import 'package:local_data_app/providers/task_provider.dart';
import 'package:local_data_app/utils/constants.dart';
import 'package:local_data_app/views/widgets/task_item.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  taskProvider.error ?? '',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => taskProvider.loadTasks(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final tasks = taskProvider.tasks;
        if (tasks.isEmpty) {
          return Center(child: Text(AppConstants.noTasksMessage));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await taskProvider.loadTasks();
          },
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskItem(task: task);
            },
          ),
        );
      },
    );
  }
}
