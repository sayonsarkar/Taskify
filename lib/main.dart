import 'package:flutter/material.dart';
import 'package:local_data_app/providers/task_provider.dart';
import 'package:local_data_app/providers/user_provider.dart';
import 'package:local_data_app/views/screens/home_screen.dart';
import 'package:local_data_app/views/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // Load user data after the widget is inserted into the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          // Show loader while fetching user details or during initialization
          if (userProvider.isLoading || !userProvider.isInitialized) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // If user is null, show welcome screen
          if (userProvider.user == null) {
            return const WelcomeScreen();
          }

          // If user exists, show home screen
          return const HomeScreen();
        },
      ),
    );
  }
}
