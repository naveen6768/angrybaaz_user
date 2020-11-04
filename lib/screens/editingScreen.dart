import 'package:flutter/material.dart';

class EditingScreen extends StatefulWidget {
  static const id = 'Editing Screen';
  @override
  _EditingScreenState createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Will proceed further from here everything is set!',
      ),
    );
  }
}
