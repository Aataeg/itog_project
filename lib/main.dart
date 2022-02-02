import 'package:flutter/material.dart';
import 'package:itog_project/auth_page.dart';
import 'package:itog_project/list_users.dart';

import 'info_todo.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      routes: {
//        '/': (context) => AuthPage(),
        '/listusers': (context) => ListUsers(),
//        '/todo': (context) => ToDo(),
      },
    );
  }
}


