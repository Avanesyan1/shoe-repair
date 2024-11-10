import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/widgets/app_bars/title_app_bar.dart';
import 'package:shoe_repair/widgets/buttons/button.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return  Scaffold(
      appBar: const TitleAppBar(title: 'Настройки'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _button('Политика конфиденциальности'),
          const SizedBox(height: 12,),
          _button('Пользовательское соглашение'),
          const Spacer(),
          Button(
            onTap: (){
              requestReview();
            },
            margin: EdgeInsets.only(right: 20, left: 20, bottom: size.height * 0.05),
            buttonColor: AppColors.primary,
            text: 'Оценить приложение',
            textStyle: AppStyles.f16w600white,
          ),
        ],
      ),
    );
  }

  Container _button(String text){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              text,style: AppStyles.f16w600black
            ),
          ),
          SvgPicture.asset(
            colorFilter: const ColorFilter.mode(
              Colors.black, 
              BlendMode.srcIn
            ),
            AppIcons.arrowRight
          )
        ],
      ),
    );
  }

  Future<void> requestReview() async {
    try {
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    } catch (e) {
      log('$e');
    }
  }
}
