import 'package:flutter/material.dart';
import 'package:student_management_provider/Core/constants.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key, this.page});
  final dynamic page;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      backgroundColor: const Color.fromARGB(255, 60, 59, 59),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Icon(
        Icons.add,
        color: constants().whiteColor,
      ),
    );
  }
}
