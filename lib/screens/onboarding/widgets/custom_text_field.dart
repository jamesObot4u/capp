import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? format;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final String? initValue;
  final int? maxlength;
  final int? maxLine;
  String? Function(String?)? validate;

  CustomTextField({
    Key? key,
    required this.hint,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.validate,
    this.maxlength,
    this.format,
    required this.padding,
    this.initValue,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validate,
        maxLines: maxLine,
        maxLength: maxlength,
        inputFormatters: format,
        initialValue: initValue,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.only(bottom: 5.0, top: 12.5)),
        onChanged: onChanged,
      ),
    );
  }
}

String? validateName(String? value) {
  if (value!.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String? validateAge(int? value) {
  if (value! <= 10)
    return 'Age must not be less than 12yrs';
  else
    return null;
}
