import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  const MyButton({
    required this.text,
    required this.onPressed,
     this.width=double.infinity,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      child: ElevatedButton(
        onPressed: (){
          onPressed();
        },
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
        ),
        child: Text(text),
      ),
    );
  }
}
