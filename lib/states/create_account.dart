import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notiandchat/models/user_model.dart';
import 'package:notiandchat/utility/app_controller.dart';
import 'package:notiandchat/utility/app_dialog.dart';
import 'package:notiandchat/utility/app_service.dart';
import 'package:notiandchat/utility/app_snackbar.dart';
import 'package:notiandchat/widgets/widget_button.dart';
import 'package:notiandchat/widgets/widget_form.dart';
import 'package:notiandchat/widgets/widget_icon_button.dart';
import 'package:notiandchat/widgets/widget_image_asset.dart';
import 'package:notiandchat/widgets/widget_image_file.dart';
import 'package:notiandchat/widgets/widget_text.dart';
import 'package:notiandchat/widgets/widget_text_button.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  AppController appController = Get.put(AppController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Account'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Obx(() {
                    print('files ---> ${appController.files.length}');
                    return appController.files.isEmpty
                        ? const WidgetImageAsset(
                            size: 200,
                          )
                        : WidgetImageFile(
                            file: appController.files.last,
                            size: 200,
                          );
                  }),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: WidgetIconButton(
                      iconData: Icons.camera,
                      pressFunc: () {
                        AppDialog(context: context).normalDialog(
                          title: 'Please Choose Camera or Gallery',
                          firstAction: WidgetTextButton(
                            label: 'Camera',
                            pressFunc: () {
                              Get.back();
                              AppService()
                                  .takePhoto(source: ImageSource.camera);
                            },
                          ),
                          secondAction: WidgetTextButton(
                            label: 'Gallery',
                            pressFunc: () {
                              Get.back();
                              AppService()
                                  .takePhoto(source: ImageSource.gallery);
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Display Name :'),
                textEditingController: nameController,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Email :'),
                textEditingController: emailController,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Password :'),
                textEditingController: passwordController,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: WidgetButton(
                  label: 'Create New Account',
                  pressFunc: () async {
                    print('you click create Accout');

                    if (appController.files.isEmpty) {
                      AppSnackBar(
                              title: 'No Avatar ?',
                              message: 'Please Take Photo')
                          .errorSnackBar();
                    } else if ((nameController.text.isEmpty) ||
                        (emailController.text.isEmpty) ||
                        (passwordController.text.isEmpty)) {
                      AppSnackBar(
                              title: 'Have Space',
                              message: 'Please Fill Every Blank')
                          .errorSnackBar();
                    } else {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        String uid = value.user!.uid;

                        print('uid ====> $uid');

                        AppService()
                            .processUploadImage(pathStorage: 'avatar')
                            .then((value) async {
                          FirebaseMessaging messaging =
                              FirebaseMessaging.instance;

                          String? token = await messaging.getToken();

                          if (token != null) {
                            print('token --> $token');

                            UserModel model = UserModel(
                                name: nameController.text,
                                uid: uid,
                                urlAvatar: appController.urlImage.value,
                                token: token);

                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(uid)
                                .set(model.toMap())
                                .then((value) => Get.back());
                          }
                        });
                      }).catchError((onError) {
                        AppSnackBar(
                                title: onError.code, message: onError.message)
                            .errorSnackBar();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
