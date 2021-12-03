import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/loginservices/loginservices.dart';
import 'package:shopping/screens/splashscreen.dart';
import 'package:shopping/services/authintication.dart';
import 'package:shopping/services/firebaseoperation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Loginservices()),
        ChangeNotifierProvider(create: (_) => Authinitication()),
        ChangeNotifierProvider(create: (_) => Firebaseoperation()),
      ],
      child: MaterialApp(
        theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: const Splashscreen(),
      ),
    );
  }
}
