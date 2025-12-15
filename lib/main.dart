import 'package:counterappblocpackg/database_helper.dart';
import 'package:counterappblocpackg/presentation/pages/list_view_data.dart';
import 'package:flutter/material.dart';

void main() {
  // Bloc.observer = LogBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> usersList = [
    {
      'name': 'Saiteja Kenam',
      'email': 'saiteja1@email.com',
    },
    {
      'name': 'Ravi Kumar',
      'email': 'ravi2@email.com',
    },
    {
      'name': 'Anita Sharma',
      'email': 'anita3@email.com',
    },
    {
      'name': 'Priya Reddy',
      'email': 'priya4@email.com',
    },
    {
      'name': 'Kiran Das',
      'email': 'kiran5@email.com',
    },
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final DatabaseHelper db = DatabaseHelper();
        db.insertUsersBatch(usersList);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const ListViewPage(),
    );
  }
}
