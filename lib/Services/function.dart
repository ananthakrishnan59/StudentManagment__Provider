import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management_provider/Core/constants.dart';
import 'package:student_management_provider/Model/student.dart';
import 'package:student_management_provider/Screens/Widgets/student_list_widget.dart';
import 'package:student_management_provider/Viewmodel/student_controller.dart';


void snackBarFunction({
  required BuildContext context,
  required String title,
  required String subtitle,
  Color? backgroundColor,
  DismissDirection? dismissDirection,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(subtitle),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    ),
  );
}

void showDeleteConfirmationDialog(BuildContext context, StudentModel student,
    StudentProvider studentController) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Are you sure you want to delete ${student.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              studentController.deleteStudent(int.parse(student.id.toString()));
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

void showStudentDetailsDialog(BuildContext context, StudentModel student) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 550,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constants().kheight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StudentImageContainerWidget(
                      student: student,
                      height: 300,
                      width: 300,
                    ),
                  ),
                  constants().kheight20,
                  Text(
                    student.name.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  constants().kheight20,
                  Text(
                    'Age: ${student.age}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Department: ${student.department.toUpperCase()}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Place: ${student.place}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Guardian Name: ${student.guardianName}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Phone No: ${student.phoneNumber}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}