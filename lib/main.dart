import 'package:flutter/material.dart';
import 'package:notes/models/note_db.dart';
import 'package:notes/models/theme_provider.dart';
import 'package:notes/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  //initialize the note isar db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => NoteDataBase(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
