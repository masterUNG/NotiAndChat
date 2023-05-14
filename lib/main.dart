import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notiandchat/states/authen.dart';
import 'package:notiandchat/states/chat.dart';
import 'package:notiandchat/utility/app_service.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/chat',
    page: () => const Chat(),
  ),
];

String? initialRoute;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        //sign Out
        initialRoute = '/authen';
        runApp(MyApp());
      } else {
        //sing In
        initialRoute = '/chat';
        AppService().findUserModelLogin().then((value) {
          runApp(MyApp());
        });
        
      }
    });

    
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,initialRoute:  initialRoute ?? '/authen',
      theme: ThemeData(useMaterial3: true),
    );
  }
}
