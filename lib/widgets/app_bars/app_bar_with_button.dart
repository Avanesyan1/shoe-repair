import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class AppBarWithButton extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithButton({
    super.key,
    required this.title,
    required this.onTap
  });

  final String title;
  final Function(TapDownDetails)? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)), 
      child: AppBar(
        backgroundColor: AppColors.primary,
        shadowColor: const Color.fromRGBO(73, 72, 182, 1),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        title: Text(
          title,
          style: AppStyles.f20w700white,
        ),
        actions: [
          GestureDetector(
            onTapDown: onTap,
            child: SvgPicture.asset(AppIcons.dots),
          ),
          const SizedBox(width: 12)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
