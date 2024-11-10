import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/models/shoe_model.dart';
import 'package:shoe_repair/routes/app_routes.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/utils/image_to_string.dart';
import 'package:shoe_repair/widgets/app_bars/title_app_bar.dart';
import 'package:shoe_repair/widgets/buttons/button.dart';
import 'package:shoe_repair/widgets/input_zone.dart';
import 'package:shoe_repair/widgets/pickers/image_zone.dart';
import 'package:shoe_repair/widgets/title.dart';

class AddShoeScreen extends StatelessWidget {
  const AddShoeScreen({
    super.key,
    this.shoe,
  });
  final ShoeModel? shoe;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController modelController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    TextEditingController ownerFullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    String selectedImagePath = '';

    //для редоктирования, лень через кубит сделать)
    if (shoe != null) {
      nameController.text = shoe?.name ?? '';
      brandController.text = shoe?.brand ?? '';
      modelController.text = shoe?.model ?? '';
      commentController.text = shoe?.comment ?? '';
      ownerFullNameController.text = shoe?.ownerFullName ?? '';
      phoneNumberController.text = shoe?.phoneNumber ?? '';
      selectedImagePath = shoe?.imagePath ?? '';
    }

    return Scaffold(
      appBar: const TitleAppBar(title: 'Добавление обуви'),
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
                ImageZone(onImagePicked: (imagePath) {
                  selectedImagePath = imagePath;
                }),
                const SizedBox(height: 12),
                buildInputZone(
                  'Кроссовки', 
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
                buildInputZone(
                  'Adidas', 
                  'Марка', 
                  brandController,
                  TextInputType.text,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле обязательно для заполнения';
                    }
                    return null;
                  },
                ),
                buildInputZone(
                  'Samba', 
                  'Модель', 
                  modelController,
                  TextInputType.text,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле обязательно для заполнения';
                    }
                    return null;
                  },
                ),
                buildInputZone(
                  'Уже второй раз приносят в починку эту пару', 
                  'Комментарий', 
                  commentController,
                  null,   
                ),
                buildTitle('О владельце'),
                buildInputZone(
                  'Иванова Мария Петровна', 
                  'ФИО', 
                  ownerFullNameController,
                  TextInputType.text,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле обязательно для заполнения';
                    }
                    return null;
                  },
                ),
                buildInputZone(
                  '+7 (098) 765 43 21', 
                  'Контактный номер', 
                  phoneNumberController,
                  TextInputType.phone,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле обязательно для заполнения';
                    }
                    final phoneRegExp = RegExp(r'^\+7 \(\d{3}\) \d{3} \d{2} \d{2}$');
                    if (!phoneRegExp.hasMatch(value)) {
                      return 'Введите корректный номер телефона';
                    }
                    return null;
                  }
                ),
                Button(
                  margin: EdgeInsets.only(top: 8, bottom: size.height * 0.05),
                  onTap: ()async{
                    if (formKey.currentState?.validate() ?? false) {
                      ShoeModel shoeModel = ShoeModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: nameController.text,
                        brand: brandController.text,
                        comment: commentController.text,
                        model: modelController.text,
                        ownerFullName: ownerFullNameController.text,
                        phoneNumber: phoneNumberController.text,
                        imagePath: await saveImageLocally(await File(selectedImagePath).readAsBytes()),
                      );
                      if (shoe == null) {
                        AppCubits.dataCubit.addShoe(shoeModel);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }else{
                        AppCubits.dataCubit.updateShoe(shoe!.id, shoeModel);
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
