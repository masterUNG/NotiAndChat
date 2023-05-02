// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.marginTop,
    this.hint,
    this.obsecu,
    this.suffixWidget,
    this.textEditingController,
    this.labelWidget,
  }) : super(key: key);

  final double? marginTop;
  final String? hint;
  final bool? obsecu;
  final Widget? suffixWidget;
  final TextEditingController? textEditingController;
  final Widget? labelWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 16),
      width: 250,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obsecu ?? false,
        decoration: InputDecoration(label: labelWidget,
          suffixIcon: suffixWidget,
          border: const OutlineInputBorder(),
          filled: true,
          hintText: hint,
        ),
      ),
    );
  }
}
