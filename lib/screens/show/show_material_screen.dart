import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/cubits/material/material_cubit.dart';
import 'package:shoe_repair/cubits/material/material_state.dart';
import 'package:shoe_repair/screens/add/add_material_screen.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/widgets/app_bars/app_bar_with_button.dart';
import 'package:shoe_repair/widgets/pickers/show_image.dart';
import 'package:shoe_repair/widgets/show_zone.dart';
import 'package:shoe_repair/widgets/title.dart';

class ShowMaterialScreen extends StatelessWidget {
  const ShowMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    AppCubits.materialCubit.getMaterial();
    return BlocBuilder<MaterialCubit, MateriallState>(
      builder: (context, state) {
        if (state is MaterialLoaded) {
          return Scaffold(
            appBar: AppBarWithButton(
              title: state.material.name, 
              onTap: (details) {
                showMenu(
                  menuPadding: const EdgeInsets.all(0),
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  context: context, 
                  position: RelativeRect.fromLTRB(size.width * 0.3, details.globalPosition.dy, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)
                          )
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Text('Редактировать', style: AppStyles.f16w400black),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddMaterialScreen(selectedMaterial: state.material,)));
                      },
                    ),
                    PopupMenuItem(
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                          )
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Text('Удалить', style: AppStyles.f16w400red),  
                      ),
                      onTap: () {
                        AppCubits.dataCubit.deleteMaterial(state.material.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  buildTitle('Основные данные'),
                  ShowImage(imagePath: state.material.imagePath),
                  buildShowZone('Название', state.material.name),
                  buildShowZone('Описание (необязательно)', state.material.description),
                  buildShowZone('Количество (штук)', state.material.count.toString()),
                ],
              ),
            ),
          );
        }else{
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator.adaptive())
          );
        }
      },
    );
  }
}
