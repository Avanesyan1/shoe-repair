import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoe_repair/theme/app_icons.dart';  
import 'package:shoe_repair/theme/app_styles.dart';  

class WorkCard extends StatelessWidget {
  const WorkCard({
    super.key,
    required this.title,
    required this.type,
    required this.name,
    required this.onTap
  });

  final String title;
  final String type;
  final String name;
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      title, style: AppStyles.f16w600black
                      ), 
                    Text(
                      '$type $name',
                      style: AppStyles.f12w400black,
                      overflow: TextOverflow.ellipsis,  
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              SvgPicture.asset(
                AppIcons.arrowRight,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(28, 28, 30, 1), 
                  BlendMode.srcIn
                ),
              )
            ],
          ),
        ),
    );
  }
}
