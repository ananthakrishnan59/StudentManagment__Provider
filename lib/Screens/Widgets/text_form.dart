import 'package:flutter/material.dart';

class TextFormFieldWidget
 extends StatelessWidget {
  const TextFormFieldWidget
  ({super.key, required this.controller,
    this.inputType,
    this.hintText,
    this.labelText,
    this.prefixicon,
    this.maxLength,
    this.validator,
    this.onChanged,});
final TextEditingController controller;
  final TextInputType? inputType;
  final String? hintText;
  final String? labelText;
  final IconData? prefixicon;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 245, 241, 241),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(style: BorderStyle.none)
        ),
        hintText: hintText,
        labelText: labelText,prefixIcon: Icon(prefixicon)
      ),
      controller: controller,
      keyboardType: inputType,
    );
  }
}