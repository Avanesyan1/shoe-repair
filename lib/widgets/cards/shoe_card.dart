import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoe_repair/theme/app_colors.dart';  
import 'package:shoe_repair/theme/app_icons.dart';  
import 'package:shoe_repair/theme/app_styles.dart';  

class ShoeCard extends StatelessWidget {
  const ShoeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.name,
    required this.onTap
  });

  final String imagePath;
  final String title;
  final String name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.45,
        height: size.height * 0.35,
        padding: const EdgeInsets.all(20), 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(5, 5),
              spreadRadius: -15,
              blurRadius: 35,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              height: size.height * 0.2,
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: size.height * 0.20,
                  padding: const EdgeInsets.all(45),
                  color: AppColors.white245,
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.addPhoto
                    ), 
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    title, 
                    style: AppStyles.f16w600black
                  ), 
                  Text(
                    name,
                    style: AppStyles.f12w400black,
                    overflow: TextOverflow.ellipsis,  
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
