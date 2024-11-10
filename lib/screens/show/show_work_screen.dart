import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/cubits/work/work_cubit.dart';
import 'package:shoe_repair/cubits/work/work_state.dart';
import 'package:shoe_repair/screens/add/add_work_screen.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:shoe_repair/widgets/app_bars/app_bar_with_button.dart';
import 'package:shoe_repair/widgets/show_zone.dart';
import 'package:shoe_repair/widgets/title.dart';

class ShowWorkScreen extends StatelessWidget {
  const ShowWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubits.workCubit.getWork();
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<WorkCubit, WorkState>(
      builder: (context, state) {
        if (state is WorkLoaded) {
          return Scaffold(
            appBar: AppBarWithButton(
              title: state.work.name, 
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddWorkScreen(work: state.work)));
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
                        AppCubits.dataCubit.deleteWork(state.work.id);
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
                  buildShowZone('Название', state.work.name),
                  buildShowZone('Дата сдачи работы', state.work.submissionDeadline),
                  buildShowZone('Стоимость', state.work.price.toString()),
                  buildShowZone('Комментарий', state.work.comment),
                  buildTitle('Материалы для работы'),
                  buildShowZone('Материал', state.work.shoeName),
                  buildShowZone('Материал', state.work.material.toString()),
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
