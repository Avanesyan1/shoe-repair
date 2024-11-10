import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/cubits/data/data_cubit.dart';
import 'package:shoe_repair/cubits/data/data_state.dart';
import 'package:shoe_repair/routes/app_routes.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/widgets/app_bars/main_app_bar.dart';
import 'package:shoe_repair/widgets/buttons/button.dart';
import 'package:shoe_repair/widgets/cards/shoe_card.dart';
import 'package:shoe_repair/widgets/cards/material_card.dart';
import 'package:shoe_repair/widgets/cards/work_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    AppCubits.dataCubit.loadData();
    final ValueNotifier<int> currentScreenIndex = ValueNotifier<int>(1);

    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state){
        if (state is DataLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: MainAppBar(
              currentPageIndex: currentScreenIndex,
              onRightButtonTap: (){
                if (currentScreenIndex.value == 2) {
                  currentScreenIndex.value = 0;
                }else{
                  currentScreenIndex.value += 1;
                }
              },
              onLeftButtonTap: (){
                if (currentScreenIndex.value == 0) {
                  currentScreenIndex.value = 2;
                }else{
                  currentScreenIndex.value -= 1;
                }
              },
              onSettingButtonTap: (){
                Navigator.pushNamed(context, AppRoutes.settingScreen);
              }
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder(
                      valueListenable: currentScreenIndex, 
                      builder: (context, index, _){
                        switch(index){
                          case 0:
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ...List.generate(state.materials.length, (index){
                                  return MaterialCard(
                                    onTap: () {
                                      AppCubits.materialCubit.setMaterial(state.materials[index]);
                                      Navigator.pushNamed(context, AppRoutes.showMaterialScreen);
                                    },
                                    imagePath: state.materials[index].imagePath,
                                    name: state.materials[index].name,
                                    description: state.materials[index].description,
                                    count: state.materials[index].count,
                                  );
                                })
                              ],
                            ),
                          );
                          case 1:
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: SizedBox(
                                width: size.width,
                                child: Wrap(
                                runAlignment: WrapAlignment.start,
                                alignment: WrapAlignment.start,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  ...List.generate(state.shoes.length, (index){
                                    return ShoeCard(
                                      imagePath: state.shoes[index].imagePath,
                                      name: state.shoes[index].ownerFullName,
                                      title: state.shoes[index].name,
                                      onTap: (){
                                        AppCubits.shoeCubit.setShoe(state.shoes[index]);
                                        Navigator.pushNamed(context, AppRoutes.showShoeScreen);
                                      },
                                    );
                                  })
                                ],
                                                                ),
                              ),
                            );
                          case 2:
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  ...List.generate(state.works.length, (index){
                                    return WorkCard(
                                      onTap: () {
                                        AppCubits.workCubit.setWork(state.works[index]);
                                        Navigator.pushNamed(context, AppRoutes.showWorkScreen);
                                      },
                                      title: state.works[index].name, 
                                      type: state.works[index].shoeName, 
                                      name: state.works[index].name
                                    );
                                  }),
                                ],
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }
                    )
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.05),
                  child: ValueListenableBuilder(
                    valueListenable: currentScreenIndex,
                    builder: (context, index, _){
                      return Button(
                        onTap: () {
                          switch(currentScreenIndex.value){
                            case 0:
                              Navigator.pushNamed(context, AppRoutes.addMaterialScreen);
                              break;
                            case 1:
                              Navigator.pushNamed(context, AppRoutes.addShoeScreen);
                              break;
                            case 2:
                              Navigator.pushNamed(context, AppRoutes.addWorkScreen);
                              break;
                          }
                        },
                        buttonColor: AppColors.primary,
                        text: _getText(index),
                        textStyle: AppStyles.f16w600white,
                        withIcon: true,
                        iconPath: AppIcons.plus,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }else{
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator.adaptive()
            )
          );
        }
      }
    );
  }
  String _getText(index){
    switch(index){
      case 0:
        return 'Добавить материал';
      case 1:
        return 'Добавить обувь';
      case 2:
        return 'Добавить работу';
    }
    return '';
  }
}