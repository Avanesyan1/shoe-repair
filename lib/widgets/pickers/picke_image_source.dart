import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class PickeImageSource extends StatelessWidget {
  const PickeImageSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Камера', style: AppStyles.f16w600black),
              leading: SvgPicture.asset(
                AppIcons.camera,
                colorFilter: const ColorFilter.mode(
                  Colors.black, 
                  BlendMode.srcIn
                ),
                height: 30,
              ),
              onTap: (){
                Navigator.of(context).pop(ImageSource.camera);
              },
            ),
            ListTile(
              title: const Text('Галерея', style: AppStyles.f16w600black),
              leading: SvgPicture.asset(
                AppIcons.gallery,
                colorFilter: const ColorFilter.mode(
                  Colors.black, 
                  BlendMode.srcIn
                ),
                height: 30,
              ),
              onTap: (){
                Navigator.of(context).pop(ImageSource.gallery);
              }
            ),
          ],
        ),
      ),
    );
  }
}