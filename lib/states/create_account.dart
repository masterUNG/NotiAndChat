import 'package:flutter/material.dart';
import 'package:notiandchat/utility/app_dialog.dart';
import 'package:notiandchat/widgets/widget_button.dart';
import 'package:notiandchat/widgets/widget_form.dart';
import 'package:notiandchat/widgets/widget_icon_button.dart';
import 'package:notiandchat/widgets/widget_image_asset.dart';
import 'package:notiandchat/widgets/widget_text.dart';
import 'package:notiandchat/widgets/widget_text_button.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

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
                  const WidgetImageAsset(
                    size: 200,
                  ),
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
                            pressFunc: () {},
                          ),
                          secondAction: WidgetTextButton(
                            label: 'Gallery',
                            pressFunc: () {},
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
                labelWidget: WidgetText(data: 'Display Name :'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: WidgetText(data: 'Email :'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: WidgetText(data: 'Password :'),
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
                  pressFunc: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
