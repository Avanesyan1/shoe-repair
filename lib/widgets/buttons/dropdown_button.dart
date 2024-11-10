import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.hintText,
    required this.values,
    required this.selectedValue,
    required this.onChanged,
  });

  final String hintText;
  final List<String> values;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final uniqueValues = values.toSet().toList();
    final validSelectedValue = uniqueValues.contains(selectedValue) ? selectedValue : null;

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: validSelectedValue,
              icon: SvgPicture.asset(AppIcons.arrowBottom),
              hint: Text(
                hintText,
                style: AppStyles.f16w400Opacity03,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              underline: const SizedBox(),
              items: uniqueValues.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppStyles.f16w400black,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null && uniqueValues.contains(newValue)) {
                  onChanged(newValue); 
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
