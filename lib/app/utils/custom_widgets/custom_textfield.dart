import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_border_radius.dart';
import 'package:travel_app/app/configs/app_size_config.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String hintText;
  final String? labelText;
  final String? errorText;
  final Widget? icon;
  final bool? obscureText;
  final bool isRequired;
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
  const CustomTextField({
    this.textEditingController,
    this.validator,
    this.readOnly,
    required this.hintText,
    this.labelText = '',
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
  });
  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    HeightWidth(context);
    return TextFormField(
      onTapOutside: (_) {
        Get.focusScope!.unfocus();
      },
      onTap: onTap,
      maxLines: maxLines,
      maxLength: maxlength,
      inputFormatters: inputformatter,
      keyboardType: keyboardType,
      controller: textEditingController,
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText ?? false,
      cursorColor: Colors.black,
      onChanged: onChanged,
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.flight_takeoff_rounded),
        prefixText: prefixText,
        suffixText: suffixText,
        prefixStyle: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: theme.onPrimary),
        suffixStyle: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: theme.onPrimary),
        contentPadding: contentpadding ??
            const EdgeInsets.only(left: 15, right: 15, top: 5),
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.bold),
        filled: false,
        errorText: errorText,
        alignLabelWithHint: false,

        label: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            children: [
              TextSpan(
                text: labelText!,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              isRequired
                  ? TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  : TextSpan(
                      text: '',
                      style: TextStyle(color: Colors.red),
                    )
            ],
          ),
        ),
        // label: CommonText(text: labelText!),
        // labelStyle: TextStyle(
        //     overflow: TextOverflow.visible,
        //     color: Colors.black,
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.bold),
      ),
    );
  }
}
