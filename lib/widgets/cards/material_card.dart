import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoe_repair/theme/app_colors.dart';  
import 'package:shoe_repair/theme/app_icons.dart';  
import 'package:shoe_repair/theme/app_styles.dart';  

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.count,
    required this.onTap
  });

  final String imagePath;
  final String name;
  final String description;
  final int count ;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(
              height: size.height * 0.08,
              width: size.width * 0.2,
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: size.height * 0.08,
                  width: size.width * 0.2,
                  color: AppColors.white245,
                  child: Center(
                    child: SvgPicture.asset(AppIcons.hammer), 
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    name, style: AppStyles.f16w600black
                    ), 
                  Text(
                    description,
                    style: AppStyles.f12w400black,
                    overflow: TextOverflow.ellipsis,  
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                Text(
                  '${count.toString()} шт.', style: AppStyles.f16w600black,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
