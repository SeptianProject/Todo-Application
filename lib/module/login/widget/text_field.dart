// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QTextField extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? value;
  final IconData preffixIcon;
  final Widget? suffixIcon;

  const QTextField({
    super.key,
    required this.label,
    this.validator,
    required this.onChanged,
    required this.preffixIcon,
    this.suffixIcon,
    this.value,
  });

  @override
  State<QTextField> createState() => _QTextFieldState();
}

class _QTextFieldState extends State<QTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.value,
      onChanged: widget.onChanged,
      cursorColor: const Color(0xff444444),
      cursorWidth: 1,
      cursorOpacityAnimates: true,
      style: const TextStyle(
          color: Color(0xff444444), fontSize: 14, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
        filled: true,
        fillColor: const Color(0xff5A7BFA).withOpacity(0.1),
        label: Text(
          widget.label,
          style: const TextStyle(
            color: Color(0xff444444),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        prefixIcon: Icon(
          widget.preffixIcon,
          color: const Color(0xff444444),
        ),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
