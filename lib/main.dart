import 'package:fizansekerleme_k/pages/admin_page.dart';
import 'package:fizansekerleme_k/pages/app_notes.dart';
import 'package:fizansekerleme_k/pages/list_sekerler.dart';
import 'package:fizansekerleme_k/pages/sign_up.dart';
import 'package:fizansekerleme_k/pages/urunler.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:fizansekerleme_k/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fizansekerleme_k/pages/app_notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fizan Şekerleme',
      routes: {
       "/loginpage":(context) => LoginPage(),
        "/signup":(context) => SignUp(),
        "/adminpage":(context) => AdminPage(),
        "/listurunler":(context)=> ListUrunler(),
        "/notal":(context)=> DosyaIslemleri(kayitislemi: KayitIslemleri(),),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff21254A),
      ),
      home: Scaffold(
        body: AdminPage(),
      ),
    );
  }
}

