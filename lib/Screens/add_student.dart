

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

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Studentscontroller = context.read<StudentProvider>();

    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    TextEditingController guardianNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.black,
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
                  builder: (context, StudentProvider, child) => 
                InkWell(
                  onTap: () async {
                    String? imagePath =
                        await Studentscontroller.pickImage(ImageSource.gallery);
                  Studentscontroller.setPickedImage(imagePath?? '');
                  },
                  child:
                      CircleAvatarWidget(pickedimage: Studentscontroller.pickedimage, radius: 80),
                ),
          )),
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
                        controller: nameController,
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
                        controller: ageController,
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
                          controller: departmentController,
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
                        controller: placeController,
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
                        controller: phoneNoController,
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
                        controller: guardianNameController,
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
                            // if every field is validated
                            if (formKey.currentState!.validate() &&
                                Studentscontroller.pickedimage.isNotEmpty) {
                              Studentscontroller.addStudent(StudentModel(
                                  name: nameController.text,
                                  age: int.parse(ageController.text),
                                  department: departmentController.text,
                                  place: placeController.text,
                                  phoneNumber:
                                      int.parse(phoneNoController.text),
                                  guardianName: guardianNameController.text,
                                  imageUrl: Studentscontroller.pickedimage));
                              // clearing the fields after saving
                              nameController.clear();
                              ageController.clear();
                              departmentController.clear();
                              placeController.clear();
                              phoneNoController.clear();
                              guardianNameController.clear();
                           
                              print(
                                  'form is validated ${Studentscontroller.students}');
                              snackBarFunction(
                                context: context,
                                title: 'Success',
                                subtitle: 'Submitted Successfully',
                                backgroundColor: Colors.green,
                                
                              );
                            }
                            // if the image is not picked up
                            else if (Studentscontroller.pickedimage.isEmpty) {
                              snackBarFunction(
                                context: context,
                                title: 'Submission Failed',
                                subtitle: 'Please select an image',
                                backgroundColor: Colors.red,
                                dismissDirection: DismissDirection.horizontal,
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
                              style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 125, 228, 7),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
