import 'dart:io';

import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({super.key,
  required this.pickedimage,
  this.radius});
  final String pickedimage;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Color.fromARGB(255, 216, 210, 210),
      backgroundImage: pickedimage.isNotEmpty
      ?FileImage(File(pickedimage))
      : null,
      child: pickedimage.isEmpty
      ?Icon(Icons.person,size: 35,)
      :null,
    );
  }
}
