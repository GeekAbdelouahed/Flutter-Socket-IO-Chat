import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/messages_provider.dart';
import './ui/screens/join.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MessagesProvider(),
      child: MaterialApp(
        title: 'Flutter Socket IO Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.pink.withOpacity(.8),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
        ),
        home: JoinScreen(),
      ),
    );
  }
}
