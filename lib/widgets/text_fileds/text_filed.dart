import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.iconPath = '',
    this.borderRadius = 12,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(8),
    this.hintText,
    required this.textController,
    this.keyboardType,
    this.color,
    this.icon = false,
    this.onTap,
    this.validator,
    this.inputFormatters
  });

  final String iconPath;
  final double borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool icon;

  final String? hintText;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final Color? color;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,   
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          inputFormatters: inputFormatters,
          style: AppStyles.f16w400black,
          decoration: InputDecoration(
            contentPadding: padding ?? const EdgeInsets.all(8),   
            hintText: hintText,
            hintStyle: AppStyles.f16w400Opacity03,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.greyO03),
            ),
          ),
          controller: textController,
          keyboardType: keyboardType,
          validator: validator,
        ),
      ),
    );
  }
}
