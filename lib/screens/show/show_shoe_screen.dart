import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/cubits/shoe/shoe_cubit.dart';
import 'package:shoe_repair/cubits/shoe/shoe_state.dart';
import 'package:shoe_repair/screens/add/add_shoe_screen.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/widgets/app_bars/app_bar_with_button.dart';
import 'package:shoe_repair/widgets/pickers/show_image.dart';
import 'package:shoe_repair/widgets/show_zone.dart';
import 'package:shoe_repair/widgets/title.dart';

class ShowShoeScreen extends StatelessWidget {
  const ShowShoeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    AppCubits.shoeCubit.getShoe();
    return BlocBuilder<ShoeCubit, ShoeState>(
      builder: (context, state) {
        if (state is ShoeLoaded) {
          return Scaffold(
            appBar: AppBarWithButton(
              title: state.shoe.name, 
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
                        child: const Text('Запрос данных', style: AppStyles.f16w400black),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddShoeScreen(shoe: state.shoe,)));
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
                        AppCubits.dataCubit.deleteShoe(state.shoe.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    buildTitle('Основные данные'),
                    ShowImage(imagePath: state.shoe.imagePath),
                    buildShowZone('Название', state.shoe.name),
                    buildShowZone('Марка', state.shoe.brand),
                    buildShowZone('Модель', state.shoe.model),
                    buildShowZone('Комментарий', state.shoe.comment),
                    buildTitle('О владельце'),
                    buildShowZone('ФИО', state.shoe.ownerFullName),
                    buildShowZone('Контактный номер', state.shoe.phoneNumber),
                  ],
                ),
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
