import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  MainAppBar({
    super.key,
    required this.currentPageIndex,
    required this.onRightButtonTap,
    required this.onLeftButtonTap,
    required this.onSettingButtonTap,
  });
  
  final titles = ['Материалы', 'Обувь', 'Работы'];
  final ValueNotifier<int> currentPageIndex;
  final Function()? onLeftButtonTap;
  final Function()? onRightButtonTap;
  final Function()? onSettingButtonTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)), 
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        shadowColor: AppColors.primary,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: currentPageIndex, 
          builder: (context, intex, _){
            return Text(
              getTitle(intex), 
              style: AppStyles.f20w700white
            );
          }
        ),
        actions: [
          SvgPicture.asset(AppIcons.note),
          GestureDetector(
            onTap: onSettingButtonTap,
            child: SvgPicture.asset(AppIcons.setting)
          ),
          const SizedBox(width: 20,)
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100), 
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onLeftButtonTap,
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.arrowLeft),
                        ValueListenableBuilder(
                          valueListenable: currentPageIndex,
                          builder: (context, index, _){
                              return Text(getTitle(index - 1),style: AppStyles.f12w700white,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: currentPageIndex,
                  builder: (context, currentIndex, _){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentIndex == index ? Colors.white : Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    );
                  }
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onRightButtonTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: currentPageIndex,
                          builder: (context, index, _){
                              return Text(getTitle(index + 1),style: AppStyles.f12w700white,
                            );
                          },
                        ),
                        SvgPicture.asset(AppIcons.arrowRight),
                      ],
                    )
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  String getTitle(int index) {

    index = index % titles.length;

    if (index < 0) {
      index = titles.length + index;
    }

    return titles[index];
  }


  @override
  Size get preferredSize => const Size.fromHeight(80);
}