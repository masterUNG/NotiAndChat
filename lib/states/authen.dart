import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notiandchat/states/chat.dart';
import 'package:notiandchat/states/create_account.dart';
import 'package:notiandchat/utility/app_controller.dart';
import 'package:notiandchat/utility/app_snackbar.dart';
import 'package:notiandchat/widgets/widget_button.dart';
import 'package:notiandchat/widgets/widget_form.dart';
import 'package:notiandchat/widgets/widget_icon_button.dart';
import 'package:notiandchat/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('redEye ---> ${appController.redEye}');
            return SafeArea(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetForm(
                        textEditingController: emailController,
                        marginTop: 100,
                        hint: 'Email :',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetForm(
                        textEditingController: passwordController,
                        hint: 'Password :',
                        obsecu: appController.redEye.value,
                        suffixWidget: WidgetIconButton(
                          iconData: appController.redEye.value
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          pressFunc: () {
                            appController.redEye.value =
                                !appController.redEye.value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: WidgetButton(
                          label: 'Login',
                          pressFunc: () async {
                            if ((emailController.text.isEmpty) ||
                                (passwordController.text.isEmpty)) {
                              AppSnackBar(
                                      title: 'Have Space',
                                      message: 'Please Fill Every Blank')
                                  .errorSnackBar();
                            } else {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                Get.offAll(const Chat());
                                AppSnackBar(
                                        title: 'Welcome',
                                        message: 'Login Success')
                                    .normalSnackBar();
                              }).catchError((onError) {
                                AppSnackBar(
                                        title: onError.code,
                                        message: onError.message)
                                    .errorSnackBar();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const CreateAccount());
        },
        child: const WidgetText(data: 'Add'),
      ),
    );
  }
}
