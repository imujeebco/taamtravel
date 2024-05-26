import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_border_radius.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField(
      {required this.text,
      required this.hintText,
      this.value,
      this.items,
      this.onChanged,
      this.errorColor,
      this.errorText,
      this.focusNode,
      this.icon,
      this.inputformatter,
      this.keyboardType,
      this.labelText,
      this.maxlength,
      this.obscureText,
      this.onTap,
      this.readOnly,
      this.validator,
      super.key});

  final String text;
  final String hintText;
  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String? labelText;
  final String? errorText;
  final Widget? icon;
  final bool? obscureText;
  final Function()? onTap;
  //final Function(String? value)? onChanged;
  final FocusNode? focusNode;
  final int? maxlength;
  final List<TextInputFormatter>? inputformatter;
  final Color? errorColor;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    return DropdownButtonFormField(
      isExpanded: false,
      dropdownColor: theme.primary,
      style: TextStyle(color: theme.onSecondary),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        // isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor ?? theme.secondary,
          ),
          borderRadius: AppBorderRadius.circularBorderHigh,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.secondary,
          ),
          borderRadius: AppBorderRadius.circularBorderHigh,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.secondary,
          ),
          borderRadius: AppBorderRadius.circularBorderHigh,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor ?? theme.secondary,
          ),
          borderRadius: AppBorderRadius.circularBorderHigh,
        ),
        fillColor: theme.secondary,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: labelText,
        filled: true,
        errorText: errorText,
      ),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
