import 'package:flutter/material.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.onCancel,
    required this.onSubmit
  });

  final Function()? onCancel;
  final Function(Object?)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      view: DateRangePickerView.year,
      selectionColor: AppColors.primary,
      selectionTextStyle: const TextStyle(color: Colors.white),
      todayHighlightColor: AppColors.primary,
      backgroundColor: Colors.white,
      showNavigationArrow: true,
      showActionButtons: true,
      headerStyle: const DateRangePickerHeaderStyle(
        backgroundColor: AppColors.primary,
        textStyle: AppStyles.f16w600white,
      ),
      monthCellStyle: const DateRangePickerMonthCellStyle(
        textStyle: TextStyle(color: Colors.black),
      ),
      yearCellStyle: const DateRangePickerYearCellStyle(
        todayTextStyle: TextStyle(color: AppColors.primary),
        textStyle: TextStyle(color: Colors.black),
      ),
      onCancel: onCancel,
      onSubmit: onSubmit,
      cancelText: 'Отмена',
    );
  }
}
