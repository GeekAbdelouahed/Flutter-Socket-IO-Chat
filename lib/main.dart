import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/messages_provider.dart';
import './widgets/chat.dart';

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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController;

  void _joinChat() {
    if (_textEditingController.text.isEmpty) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ChatScreen(_textEditingController.text),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Socket IO Chat'),
      ),
      body: Center(
        child: Container(
          height: 200,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                    ),
                    onSubmitted: (_) {
                      _joinChat();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                      onPressed: _joinChat,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.title.color,
                      child: Text('Join'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
