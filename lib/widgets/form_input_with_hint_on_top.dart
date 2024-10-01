import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputWithHint extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final Color borderColor;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final Function? onChanged;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextInputAction? keyboardAction;
  final String? hintText;
  final int maxLine;
  final int? maxLength;
  final bool isEnabled;
  final TextEditingController? controller;
  final double formSize;
  final double horizontalTextPadding;
  final double textFieldHeight;
  final Color? fillColor;
  final double formRadius;
  final bool isDigitsOnly;

  const FormInputWithHint({
    super.key,
    this.label,
    this.obscureText = false,
    this.borderColor = Colors.white,
    this.keyboardType,
    this.keyboardAction,
    this.formSize = 48,
    this.prefixIcon,
    this.suffixIcon,
    this.horizontalTextPadding = 20,
    this.controller,
    this.isDigitsOnly = false,
    this.fillColor = Colors.white,
    this.isEnabled = true,
    this.maxLine = 1,
    this.maxLength,
    this.errorText,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    required this.hintText,
    this.textFieldHeight = 16,
    this.formRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      enabled: isEnabled,
      controller: controller,
      maxLength: maxLength,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        enabled: isEnabled,
        filled: true,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        fillColor: fillColor,
        alignLabelWithHint: true,
        /*  border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(formRadius),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.solid,
          ),
        ),*/
        contentPadding: EdgeInsets.symmetric(
          vertical: textFieldHeight,
          horizontal: horizontalTextPadding,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        errorMaxLines: 3,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(formRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(formRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(formRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(formRadius),
        ),
      ),
      inputFormatters: [
        if (isDigitsOnly) FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(
          fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),

      /*style: const TextStyle(fontSize: 16, letterSpacing: 0.7),*/
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: keyboardAction,
      maxLines: maxLine,
      key: key,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
    );
  }
}
