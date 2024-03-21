

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/Core/constants.dart';
import 'package:student_management_provider/Model/student.dart';
import 'package:student_management_provider/Screens/Widgets/app_bar.dart';
import 'package:student_management_provider/Screens/Widgets/circle_avatar.dart';
import 'package:student_management_provider/Screens/Widgets/text_form.dart';
import 'package:student_management_provider/Services/function.dart';
import 'package:student_management_provider/Viewmodel/student_controller.dart';


class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.student});
  final StudentModel student;
  @override
  Widget build(BuildContext context) {
    final studentController = context.read<StudentProvider>();
    TextEditingController nameeditingController =
        TextEditingController(text: student.name);
    TextEditingController ageeditingController =
        TextEditingController(text: student.age.toString());
    TextEditingController departmenteditingController =
        TextEditingController(text: student.department);
    TextEditingController placeeditingController =
        TextEditingController(text: student.place);
    TextEditingController phoneNoeditingController =
        TextEditingController(text: student.phoneNumber.toString());
    TextEditingController guardianNameeditingController =
        TextEditingController(text: student.guardianName);
    final formKey = GlobalKey<FormState>();
    

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBarWidget(
            onTapLeft: () {
               Navigator.pop(context);
            },
            title: 'Enter the details',
            lefticon: Icons.arrow_back,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                 Center(
                  child: Consumer<StudentProvider>(
                    builder: (context, studentprovider, child) {
                      if (studentController.pickedimage.isEmpty) {
                        studentController.setInitialImage(student.imageUrl);
                      }

                      return InkWell(
                        onTap: () async {
                          final imagepath = await studentController
                              .pickImage(ImageSource.gallery);
                          studentController.setPickedImage(imagepath ?? '');
                        },
                        child: CircleAvatarWidget(
                            pickedimage: studentController.pickedimage,
                            radius: 80),
                      );
                    },
                  ),
                ),
                constants().kheight20,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid name';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: nameeditingController,
                          hintText: 'Enter the name',
                          labelText: 'Name',
                          inputType: TextInputType.name,
                        ),
                           constants().kWidth10,
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.parse(value) >= 120 ||
                                int.parse(value) <= 0) {
                              return 'please enter a valid age';
                            }
                            return null;
                          },
                          prefixicon: Icons.numbers,
                          controller: ageeditingController,
                          hintText: 'Enter the age',
                          labelText: 'Age',
                          inputType: TextInputType.number,
                        ),
                           constants().kWidth10,
                        TextFormFieldWidget(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'please enter a valid department';
                              }
                              return null;
                            },
                            prefixicon: Icons.person,
                            controller: departmenteditingController,
                            hintText: 'Enter the department',
                            labelText: 'Department',
                            inputType: TextInputType.text),
                               constants().kWidth10,
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid place';
                            }
                            return null;
                          },
                          prefixicon: Icons.location_city,
                          controller: placeeditingController,
                          hintText: 'Enter the place',
                          labelText: 'Place',
                          inputType: TextInputType.text,
                        ),
                           constants().kWidth10,
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'please enter a valid phone no';
                            }
                            return null;
                          },
                          prefixicon: Icons.phone,
                          controller: phoneNoeditingController,
                          hintText: 'Enter the phone number',
                          labelText: 'Contact Number',
                          inputType: TextInputType.number,
                        ),
                           constants().kWidth10,
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid name';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: guardianNameeditingController,
                          hintText: 'Enter the name of the Guardian',
                          labelText: 'Guardian Name',
                          inputType: TextInputType.name,
                        ),
                        constants().kheight10,
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(5),
                                backgroundColor: MaterialStatePropertyAll(
                                    constants().appColor)),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  studentController.pickedimage.isNotEmpty) {
                                studentController.updateStudent(StudentModel(
                                    id: student.id,
                                    name: nameeditingController.text,
                                    age: int.parse(ageeditingController.text),
                                    department:
                                        departmenteditingController.text,
                                    place: placeeditingController.text,
                                    phoneNumber: int.parse(
                                        phoneNoeditingController.text),
                                    guardianName:
                                        guardianNameeditingController.text,
                                    imageUrl: studentController.pickedimage));
                                print(
                                    'form is validated ${studentController.students}');
                                snackBarFunction(
                                  context:context,
                                    title: 'Success',
                                    subtitle: 'Edited Successfully',
                                    backgroundColor: Colors.green,
                                  );
                              }

                              // if the image is not picked up
                              else if (studentController.pickedimage.isEmpty) {
                                snackBarFunction(
                                  context: context,
                                    title: 'Submission Failed',
                                    subtitle: 'Please select an image',
                                    backgroundColor: Colors.red,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    );
                              } else {
                                print('not valid');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                'SUBMIT',
                                style: GoogleFonts.openSans(
                                    color: constants().whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          )),
        ));
  }
}
