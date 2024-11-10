import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoe_repair/routes/app_routes.dart';
import 'package:shoe_repair/services/preference_service.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/widgets/buttons/button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final PageController pageController = PageController();
    final ValueNotifier<int> currentScreen = ValueNotifier<int>(0); 

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          SizedBox(
            width: size.width,
            height: size.height * 0.65,
            child: PageView(
              controller: pageController,
              onPageChanged: (int index) {
                currentScreen.value = index;
              },
              children: [
                _buildIntroPage(
                  title: "Храните информацию о материалах",
                  imagePath: AppIcons.intro1,
                ),
                _buildIntroPage(
                  title: "Структурируйте информацию об обуви и её владельце",
                  imagePath: AppIcons.intro2,
                ),
                _buildIntroPage(
                  title: "Держите под контролем количество рабочих задач",
                  imagePath: AppIcons.intro3,
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: currentScreen,
            builder: (context, currentIndex, _){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index ? AppColors.primary : AppColors.greyO03,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              );
            }
          ),
          const Spacer(),
          ValueListenableBuilder<int>(
            valueListenable: currentScreen,
            builder: (context, currentPage, child) {
              return Column(
                children: [
                  Button(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: size.height * 0.05),
                    onTap: ()async{
                      if (currentPage != 2) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else {
                        PreferenceService().setFirstLaunchCompleted();
                        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                      }
                    },
                    buttonColor: AppColors.primary,
                    text: currentPage == 2 ? 'Начать' : 'Продолжить',
                    textStyle: AppStyles.f16w600white,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIntroPage({required String title, required String imagePath}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          imagePath
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style:AppStyles.f20w700black
        ),
      ],
    );
  }
}
