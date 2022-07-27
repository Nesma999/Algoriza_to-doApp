import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String payload;
  const NotificationScreen({
    required this.payload,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
