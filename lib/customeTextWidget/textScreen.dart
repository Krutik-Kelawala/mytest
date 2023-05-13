import 'package:flutter/material.dart';
import 'package:mytest/customeTextWidget/customeTextWidge.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Widget")),
      body: Column(children: [
        CustomeTextWidget(
            textString: "Abc",
            style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 100)),
      ]),
    );
  }
}
