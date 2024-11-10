import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    this.iconPath = '',
    this.borderRadius = 12,
    this.margin = const EdgeInsets.symmetric(horizontal: 0),
    this.padding = const EdgeInsets.all(8),
    this.hintText = '',
    this.text = '',
    this.color,
    this.icon = false,
    this.onTap, 
  });

  final String iconPath;
  final double borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String hintText;
  final String text;
  final Color? color;
  final bool icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyO03
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text == '' ? hintText : text, 
                style: text == '' ? AppStyles.f16w400Opacity03 : AppStyles.f16w400black
              ),
            ),
            if (icon)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    theme.hintColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
