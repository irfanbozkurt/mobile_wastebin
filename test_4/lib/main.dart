import 'package:flutter/material.dart';

import 'mock/data.dart' as data;
import 'models/lib.dart';

import 'widgets/email_list.dart';
import 'home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: Home(currentUser: data.users[0]),
    );
  }
}
