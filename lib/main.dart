import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/database.dart';
import 'screens/home_page/home_page.dart';
import 'package:path/path.dart';
import 'logic/providers/to_do_lists_provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  final db = ToDoDatabase.instance; // Get the database instance
  await db.database; // Initialize the database

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToDoListsProvider.db()),
      ],
      child: MaterialApp(
        title: 'To Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
