import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notiandchat/utility/app_service.dart';
import 'package:notiandchat/widgets/widget_icon_button.dart';
import 'package:notiandchat/widgets/widget_text.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();
    AppService().aboutNoti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Chat'),
        actions: [
          WidgetIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () async {
              await FirebaseAuth.instance
                  .signOut()
                  .then((value) => Get.offAllNamed('/authen'));
            },
          )
        ],
      ),
    );
  }
}
