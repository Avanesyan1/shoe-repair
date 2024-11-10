import 'package:flutter/material.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/utils/input_formatter.dart';
import 'package:shoe_repair/widgets/text_fileds/text_filed.dart';

Padding buildInputZone(String hintText, title, TextEditingController controller, [TextInputType? keyboaedType, String? Function(String?)? validator]){
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.f12w400black,),
        const SizedBox(height: 2),
        CustomTextField(
          inputFormatters: keyboaedType == TextInputType.phone ? [phoneFormatter] : null,
          keyboardType: keyboaedType,
          hintText: hintText,
          textController: controller,
          validator: validator
        )
      ],
    ),
  );
}