import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/student_notifier.dart';
import 'view/home.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => StudentNotifier()),
    ],child: MyApp(),));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.purple),
        primaryColor: Colors.deepPurple,
        backgroundColor: Colors.purpleAccent,
      ),
      home: Home(),
    );
  }
}
