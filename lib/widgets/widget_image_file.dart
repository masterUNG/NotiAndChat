// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class WidgetImageFile extends StatelessWidget {
  const WidgetImageFile({
    Key? key,
    required this.file,
    this.size,
  }) : super(key: key);

  final File file;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.file(file, width: size, height: size, fit:  BoxFit.cover,);
  }
}
