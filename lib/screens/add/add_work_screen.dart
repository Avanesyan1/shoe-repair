import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/cubits/data/data_cubit.dart';
import 'package:shoe_repair/cubits/data/data_state.dart';
import 'package:shoe_repair/models/work_model.dart';
import 'package:shoe_repair/routes/app_routes.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/utils/date_utils.dart';
import 'package:shoe_repair/widgets/app_bars/title_app_bar.dart';
import 'package:shoe_repair/widgets/buttons/button.dart';
import 'package:shoe_repair/widgets/buttons/button_with_icon.dart';
import 'package:shoe_repair/widgets/buttons/dropdown_button.dart';
import 'package:shoe_repair/widgets/input_zone.dart';
import 'package:shoe_repair/widgets/pickers/date_picker.dart';
import 'package:shoe_repair/widgets/title.dart';

class AddWorkScreen extends StatelessWidget {
  const AddWorkScreen({
    super.key,
    this.work
  });

  final WorkModel? work;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    TextEditingController materialsController = TextEditingController();
    ValueNotifier<String> submissionDeadline = ValueNotifier('');
    ValueNotifier<String?> selectedShoe = ValueNotifier('');
    ValueNotifier<String?> selectedMaterial = ValueNotifier('');

    if (work != null) {
      nameController.text = work?.name ?? '';
      priceController.text = work?.price.toString() ?? '';
      commentController.text = work?.comment ?? '';
      materialsController.text = work?.material ?? '';
      submissionDeadline.value = work?.submissionDeadline ?? '';
      selectedShoe.value = work?.shoeName ?? '';
      selectedMaterial.value = work?.material ?? '';
    }

    return Scaffold(
      appBar: const TitleAppBar(title: 'Добавление работы'),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          if (state is DataLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      buildTitle('Основные данные'),
                      buildInputZone('Поменять подошву', 'Название', nameController, TextInputType.text, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Это поле обязательно для заполнения';
                        }
                        return null;
                      }),
                      _buildInputZoneWithIcon('ДД / ММ / ГГ', 'Дата сдачи работы', submissionDeadline, size),
                      buildInputZone('1 500 рублей', 'Стоимость', priceController, TextInputType.number, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Это поле обязательно для заполнения';
                        }
                        final price = int.tryParse(value);
                        if (price == null || price <= 0) {
                          return 'Введите корректную стоимость';
                        }
                        return null;
                      }),
                      buildInputZone('Уже второй раз приносят в починку эту пару ', 'Комментарий', commentController, TextInputType.text, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Это поле обязательно для заполнения';
                        }
                        return null;
                      }),
                      buildTitle('Обувь'),
                      _buildDropDownZone(
                        'Ботинки из списка',
                        'Название',
                        state.shoes.map((shoe) => shoe.name).toList(),
                        selectedShoe,
                      ),
                      buildTitle('Материалы для работы'),
                      _buildDropDownZone(
                        'Материал из списка',
                        'Материал',
                        state.materials.map((material) => material.name).toList(),
                        selectedMaterial,
                      ),
                      Button(
                        margin: EdgeInsets.only(bottom: size.height * 0.05),
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            WorkModel workModel = WorkModel(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: nameController.text,
                              submissionDeadline: submissionDeadline.value,
                              price: int.parse(priceController.text),
                              shoeName: selectedShoe.value.toString(),
                              comment: commentController.text,
                              material: selectedMaterial.value.toString()
                            );
                            if(work == null){
                              AppCubits.dataCubit.addWork(workModel);
                              Navigator.pop(context);
                            }else{
                              AppCubits.dataCubit.updateWork(work!.id, workModel);
                              Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
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
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }

  Padding _buildInputZoneWithIcon(String hintText, String title, ValueNotifier<String> submissionDeadline, Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.f12w400black),
          const SizedBox(height: 2),
          ValueListenableBuilder<String>(
            valueListenable: submissionDeadline,
            builder: (context, value, _) {
              return ButtonWithIcon(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 0.4,
                          child: DatePicker(
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            onSubmit: (date) {
                              submissionDeadline.value =
                                  DateFormatUtils.formatToDDMMYYYY(DateTime.parse(date.toString()));
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                hintText: hintText,
                text: value.isNotEmpty ? value : '',
                icon: true,
                iconPath: AppIcons.calendar,
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _buildDropDownZone(String hintText, String title, List<String> values, ValueNotifier<String?> selectedValue) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.f12w400black),
        const SizedBox(height: 2),
        ValueListenableBuilder<String?>(
          valueListenable: selectedValue,
          builder: (context, value, _) {
            return CustomDropdownButton(
              hintText: hintText,
              values: values,
              selectedValue: value ?? '',  
              onChanged: (newValue) {
                selectedValue.value = newValue;
              },
            );
          },
        ),
      ],
    ),
  );
}

}
