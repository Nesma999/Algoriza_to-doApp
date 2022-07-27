import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool readOnly;
  final bool showCursor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final Function? onPressedIcon;
  final Widget? suffixIcon;
  const MyTextField({
    this.readOnly=false,
    this.showCursor=true,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.onPressedIcon,
    this.suffixIcon,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      showCursor: showCursor,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.grey[100]!
            )
        ),
      ),
    );
  }
}
