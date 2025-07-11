import 'package:flutter/material.dart';
import 'package:local_data_app/main.dart';
import 'package:local_data_app/providers/task_provider.dart';
import 'package:local_data_app/providers/user_provider.dart';
import 'package:local_data_app/utils/constants.dart';
import 'package:local_data_app/views/screens/add_task_screen.dart';
import 'package:local_data_app/views/screens/task_list_screen.dart';
import 'package:local_data_app/views/widgets/custom_app_bar.dart';
import 'package:local_data_app/views/widgets/custom_fab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            final user = userProvider.user;
            return CustomAppBar(
              title: '${AppConstants.welcomeBack}, ${user?.name ?? ""}!',
              onLogout: () => _handleLogout(context),
              additionalActions: [
                PopupMenuButton<TaskFilter>(
                  icon: const Icon(Icons.filter_list),
                  onSelected: (TaskFilter filter) {
                    context.read<TaskProvider>().setFilter(filter);
                  },
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry<TaskFilter>>[
                        const PopupMenuItem<TaskFilter>(
                          value: TaskFilter.all,
                          child: Text('All Tasks'),
                        ),
                        const PopupMenuItem<TaskFilter>(
                          value: TaskFilter.completed,
                          child: Text('Completed'),
                        ),
                        const PopupMenuItem<TaskFilter>(
                          value: TaskFilter.pending,
                          child: Text('Pending'),
                        ),
                      ],
                ),
              ],
            );
          },
        ),
      ),
      body: const TaskListScreen(),
      floatingActionButton: CustomFAB(
        onPressed: () => _navigateToAddTask(context),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    await context.read<UserProvider>().clearUser();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainApp()),
      );
    }
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );
  }
}
