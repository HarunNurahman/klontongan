import 'package:flutter/material.dart';
import 'package:klontongan/core/utils/styles.dart';

class CustomTextForm extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? errorMessage;
  final bool isEnabled;
  const CustomTextForm({
    super.key,
    required this.labelText,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    this.errorMessage,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: blackTextStyle.copyWith(fontWeight: medium),
        ),
        const SizedBox(height: 4),
        TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          enabled: isEnabled,
          style: blackTextStyle.copyWith(fontWeight: medium),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: grayTextStyle,
            errorText: errorMessage,
            errorStyle: whiteTextStyle.copyWith(color: redColor),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: grayColor),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grayColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grayColor),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
