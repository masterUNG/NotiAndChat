import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notiandchat/models/chat_model.dart';
import 'package:notiandchat/utility/app_controller.dart';
import 'package:notiandchat/utility/app_service.dart';
import 'package:notiandchat/widgets/widget_form.dart';
import 'package:notiandchat/widgets/widget_icon_button.dart';
import 'package:notiandchat/widgets/widget_text.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().aboutNoti();
    AppService().readAllChat();
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
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('chatModels ---> ${appController.chatModels.length}');
              return SizedBox(
                width: boxConstraints.maxWidth,
                height: boxConstraints.maxHeight,
                child: Stack(
                  children: [
                    appController.chatModels.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: appController.chatModels.length,
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: appController
                                          .chatModels[index].mapChat['uid']
                                          .toString() ==
                                      appController.userModels.last.uid
                                          .toString()
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                BubbleSpecialThree(
                                  text: appController.chatModels[index].chat,
                                  color: appController
                                              .chatModels[index].mapChat['uid']
                                              .toString() ==
                                          appController.userModels.last.uid
                                              .toString()
                                      ? Colors.indigo
                                      : Colors.purple,
                                  textStyle:
                                      const TextStyle(color: Colors.white),isSender: appController
                                          .chatModels[index].mapChat['uid']
                                          .toString() ==
                                      appController.userModels.last.uid
                                          .toString(),
                                ),
                              ],
                            ),
                          ),
                    Positioned(
                      bottom: 8,
                      child: SizedBox(
                        width: boxConstraints.maxWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            WidgetForm(
                              marginTop: 0,
                              textEditingController: textEditingController,
                            ),
                            WidgetIconButton(
                              iconData: Icons.send,
                              pressFunc: () async {
                                if (textEditingController.text.isNotEmpty) {
                                  ChatModel chatModel = ChatModel(
                                      chat: textEditingController.text,
                                      mapChat:
                                          appController.userModels.last.toMap(),
                                      timestamp:
                                          Timestamp.fromDate(DateTime.now()));

                                  print('chatModel ----> ${chatModel.toMap()}');

                                  await FirebaseFirestore.instance
                                      .collection('chat')
                                      .doc()
                                      .set(chatModel.toMap())
                                      .then((value) {
                                    textEditingController.text = '';
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
