import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_utility.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    this.suffixIcon,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.onChanged,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.onSaved,
    required this.label,
    required this.hint,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onSaved: onSaved,
            obscureText: obscureText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autocorrect: true,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintText: hint,
              hintStyle: const TextStyle(color: ColorUtility.grey),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorUtility.secondary, width: 2),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
