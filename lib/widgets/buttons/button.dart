import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.borderRadius = 12,
    this.text = '',
    this.buttonColor,
    this.color,
    this.fontSize,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
    this.onTap,
    this.textStyle,
    this.withIcon = false,
    this.iconPath
  });

  final double borderRadius;
  final String text;
  final Color? color;
  final Color? buttonColor;
  final double? fontSize;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function()? onTap;
  final TextStyle? textStyle;
  final String? iconPath;
  final bool withIcon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        width: size.width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(withIcon && iconPath != null)
              SvgPicture.asset(iconPath!),
              Text(text, style: textStyle ?? theme.textTheme.bodyMedium),
            ]
          )
        ),
      )
    );
  }
}