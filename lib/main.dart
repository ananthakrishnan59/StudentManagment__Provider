import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/Screens/student_list.dart';
import 'package:student_management_provider/Viewmodel/student_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        )
      ],
      child: const MaterialApp(
        title: 'EduSync Provider',
        debugShowCheckedModeBanner: false,
        home: StudentListScreen(),
      ),
    );
  }
}
