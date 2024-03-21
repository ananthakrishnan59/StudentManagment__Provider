import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/Core/constants.dart';
import 'package:student_management_provider/Model/student.dart';
import 'package:student_management_provider/Screens/Widgets/app_bar.dart';
import 'package:student_management_provider/Screens/Widgets/flotting_action_btn.dart';
import 'package:student_management_provider/Screens/Widgets/student_list_widget.dart';
import 'package:student_management_provider/Screens/add_student.dart';
import 'package:student_management_provider/Screens/edit_screen.dart';
import 'package:student_management_provider/Screens/student_search.dart';
import 'package:student_management_provider/Services/function.dart';
import 'package:student_management_provider/Viewmodel/student_controller.dart';

 

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = context.read<StudentProvider>();
    studentController.loadStudents();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: AppBarWidget(
          onTapRight: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchStudentScreen(),
              ),
            );
          },
          righticon: Icons.search,
          title: 'STUDENTS LIST',
        ),
      ),
      body: SafeArea(
      child: Center(
          child: Consumer<StudentProvider>(
            builder: (context, studentProvider, _) {
              if (studentProvider.students.isEmpty) {
                return Text(
                  'No Student Found',
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: constants().whiteColor),
                );
              } else {
                return ListView.separated(
                  physics: const ScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  separatorBuilder: (context, index) => constants().kheight10,
                  itemCount: studentProvider.students.length,
                  itemBuilder: (context, index) {
                    var student = studentProvider.students[index];
                    return InkWell(
                      onTap: () => showStudentDetailsDialog(context, student),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: StudentCardWidget(
                            student: student,
                            studentController: studentProvider),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton:
          const FloatingActionButtonWidget(page: AddStudentScreen()),
    );
  }
}

class StudentCardWidget extends StatelessWidget {
  const StudentCardWidget({
    super.key,
    required this.student,
    required this.studentController
  });

  final StudentModel student;
    final StudentProvider studentController;

  @override
  Widget build(BuildContext context) {
    return Slidable(
  endActionPane: ActionPane(
    motion: const ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: (context) {
          showDeleteConfirmationDialog(context, student,studentController);
        },
        icon: Icons.delete,
        backgroundColor: Colors.red,
      ),
      SlidableAction(
        onPressed: (context) {
        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(student: student),
              ),
            );
        },
        icon: Icons.edit,
        backgroundColor: Colors.green,
      ),
    ],
  ),
  child: Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 0, 0, 0),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 130, 128, 128).withOpacity(0.5),
          spreadRadius:3 ,
          blurRadius: 3,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            constants().kWidth10,
            StudentImageContainerWidget(
              student: student,
              height: 135,
              width: 135,
            ),
            constants().kWidth10,
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    constants().kheight10,
                    Text(
                      'Age: ${student.age}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 141, 139, 139),
                      ),
                    ),
                    Text(
                      'Department: ${student.department.toUpperCase()}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 137, 135, 135),
                      ),
                    ),
                    Text(
                      'Phone No: ${student.phoneNumber}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 119, 118, 118),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);



  }
}