import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text("صفحة الاعدادات تحت التطوير"),
        ),
        ElevatedButton(
            onPressed: () {
              (Navigator.pop(context));
            },
            child: Text("الرئيسية"))
      ],
    ));
  }
}
