// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notiandchat/widgets/widget_image_asset.dart';
import 'package:notiandchat/widgets/widget_text.dart';
import 'package:notiandchat/widgets/widget_text_button.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog(
      {required String title, Widget? firstAction, Widget? secondAction}) {
    Get.dialog(
      AlertDialog(
        icon: const WidgetImageAsset(
          size: 120,
        ),
        title: WidgetText(data: title),
        actions: [
          firstAction ?? const SizedBox(),
          secondAction ?? const SizedBox(),
          WidgetTextButton(
            label: 'Cancel',
            pressFunc: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
