import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? labelText;
  final bool readOnly;
  final void Function()? onTap;

  const CustomTextField(
      {Key? key,
      this.isPassword = false,
      this.hintText = "Enter text",
      this.focusNode,
      this.nextFocusNode,
      this.textEditingController,
      this.validator,
      this.keyboardType,
      this.onEditingComplete,
      this.inputFormatters,
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      obscureText: isPassword,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 12.0,
        ),
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.principalColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.principalColor),
        ),
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        hintStyle: const TextStyle(fontSize: 12.0, color: Colors.white),
      ),
      controller: textEditingController,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
