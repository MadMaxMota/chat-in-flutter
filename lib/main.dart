import 'package:chat_in_flutter/chat_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      home: ChatScreen(),
    );
  }
}
