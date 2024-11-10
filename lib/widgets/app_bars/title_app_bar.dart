import 'package:flutter/material.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleAppBar({
    super.key,
    required this.title,
  });

  final String title;

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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
