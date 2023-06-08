import 'package:flutter/material.dart';

class SMBPage extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const SMBPage({Key? key, required this.body, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: body,
      ),
    );
  }
}
