import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management_provider/Core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      this.lefticon,
      this.righticon,
      required this.title,
      this.onTapLeft,
      this.onTapRight});

  final IconData? lefticon;
  final IconData? righticon;
  final String title;
  final void Function()? onTapLeft;
  final void Function()? onTapRight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 25),
      ),
      elevation: 0,
      leading: InkWell(
        child: Icon(
          lefticon,
          color: constants().whiteColor,
        ),
        onTap: () {
          onTapLeft!();
        },
      ),
      actions: [
        InkWell(
          child: Icon(
            righticon,
            color: constants().whiteColor,
            size: 30,
          ),
          onTap: () {
            onTapRight!();
          },
        )
      ],
    );
  }
}
