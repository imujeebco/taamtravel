// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_border_radius.dart';
import 'package:travel_app/app/configs/app_size_config.dart';

class Custom_textfield_required extends StatelessWidget {
  const Custom_textfield_required({
    this.validator,
    this.readOnly,
    this.icon,
    this.obscureText,
    this.onTap,
    this.focusNode,
    this.keyboardType,
    this.maxlength,
    this.inputformatter,
    this.errorText,
    this.errorColor,
    this.onChanged,
    this.prefixText,
    this.suffixText,
    this.maxLines = 1,
    this.contentpadding,
    this.isRequired = false,
    super.key,
    required this.controller,
    required this.requiredLabel,
    required this.hint,
  });

  final TextEditingController controller;
  final String requiredLabel;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String? errorText;
  final Widget? icon;
  final bool? obscureText;
  final bool? isRequired;
  final Function()? onTap;
  final Function(String? value)? onChanged;
  final FocusNode? focusNode;
  final int? maxlength;
  final List<TextInputFormatter>? inputformatter;
  final Color? errorColor;
  final String? prefixText;
  final String? suffixText;
  final int? maxLines;
  final EdgeInsetsGeometry? contentpadding;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    HeightWidth(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: requiredLabel,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          maxLength: maxlength,
          inputFormatters: inputformatter,
          keyboardType: keyboardType,
          controller: controller,
          readOnly: readOnly ?? false,
          focusNode: focusNode,
          validator: validator,
          obscureText: obscureText ?? false,
          cursorColor: Colors.black,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixText: prefixText,
            suffixText: suffixText,
            prefixStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: theme.onPrimary),
            suffixStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: theme.onPrimary),
            contentPadding: contentpadding ??
                const EdgeInsets.only(left: 15, right: 0, top: 15),
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorColor ?? Colors.transparent,
              ),
              borderRadius: AppBorderRadius.circularBorderNormal,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: AppBorderRadius.circularBorderNormal),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: AppBorderRadius.circularBorderNormal,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorColor ?? Colors.red,
              ),
              borderRadius: AppBorderRadius.circularBorderNormal,
            ),
            suffixIcon: IconButton(
              icon: icon ?? const SizedBox.shrink(),
              onPressed: onTap,
            ),
            border: UnderlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: AppBorderRadius.circularBorderNormal,
            ),
            fillColor: Colors.transparent,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 11,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: hint,
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
            filled: false,
            errorText: errorText,
          ),
        )
      ],
    );
  }
}
