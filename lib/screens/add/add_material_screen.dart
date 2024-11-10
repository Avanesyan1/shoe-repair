import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/models/material_model.dart';
import 'package:shoe_repair/routes/app_routes.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/utils/image_to_string.dart';
import 'package:shoe_repair/widgets/app_bars/title_app_bar.dart';
import 'package:shoe_repair/widgets/buttons/button.dart';
import 'package:shoe_repair/widgets/input_zone.dart';
import 'package:shoe_repair/widgets/pickers/image_zone.dart';
import 'package:shoe_repair/widgets/title.dart';

class AddMaterialScreen extends StatelessWidget {
  const AddMaterialScreen({
    super.key,
    this.selectedMaterial,
  });

  final MaterialModel? selectedMaterial;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController countController = TextEditingController();
    String selectedImagePath = '';

    //для редоктирования, лень через кубит сделать)
    if (selectedMaterial != null) {
      nameController.text = selectedMaterial?.name ?? '';
      descriptionController.text = selectedMaterial?.description ?? '';
      countController.text = selectedMaterial?.count.toString() ?? '';
      selectedImagePath = selectedMaterial?.imagePath ?? '';
    }

    return Scaffold(
      appBar: const TitleAppBar(title: 'Добавление матеряла'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                buildTitle('Основные данные'),
                ImageZone(onImagePicked: (imagePath){
                  selectedImagePath = imagePath;
                }),
                const SizedBox(height: 12),
                buildInputZone(
                  'Подошва', 
                  'Название', 
                  nameController,
                  TextInputType.text,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле обязательно для заполнения';
                    }
                    return null;
                  },
                ),
                buildInputZone('Черная по толщине 12 мм', 'Описание (необязательно)', descriptionController),
                buildInputZone(
                  '10', 
                  'Количество (штук)', 
                  countController,
                  TextInputType.number,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите количество';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Введите корректное число';
                    }
                    return null;
                  },
                ),
                Button(
                  margin: const EdgeInsets.only(top: 8),
                  onTap: ()async{
                    if (formKey.currentState?.validate() ?? false) {
                      MaterialModel materialModel = MaterialModel(
                        id: DateTime.now().millisecondsSinceEpoch, 
                        name: nameController.text, 
                        description: descriptionController.text, 
                        count: int.parse(countController.text), 
                        imagePath: await saveImageLocally(await File(selectedImagePath).readAsBytes()),
                      );
                      if(selectedMaterial == null){
                        AppCubits.dataCubit.addMaterial(materialModel);
                        if(context.mounted){
                          Navigator.pop(context);
                        }
                      }else{
                        AppCubits.dataCubit.updateMaterial(selectedMaterial!.id, materialModel);
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                        }
                      }
                    }
                  },
                  buttonColor: AppColors.primary,
                  text: 'Готово',
                  textStyle: AppStyles.f16w600white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}