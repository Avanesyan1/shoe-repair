import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/data/data_cubit.dart';
import 'package:shoe_repair/cubits/image_picker/image_picker_cubit.dart';
import 'package:shoe_repair/cubits/material/material_cubit.dart';
import 'package:shoe_repair/cubits/shoe/shoe_cubit.dart';
import 'package:shoe_repair/cubits/work/work_cubit.dart';

class AppCubits {

  static final ImagePickerCubit imagePickerCubit = ImagePickerCubit();
  static final DataCubit dataCubit = DataCubit();
  static final ShoeCubit shoeCubit = ShoeCubit();
  static final MaterialCubit materialCubit = MaterialCubit();
  static final WorkCubit workCubit = WorkCubit();

  static  List<BlocProvider> get providers => [
    BlocProvider<ImagePickerCubit>(
      create: (context) => imagePickerCubit,
    ),
    BlocProvider<DataCubit>(
      create: (context) => dataCubit,
    ),
    BlocProvider<ShoeCubit>(
      create: (context) => shoeCubit,
    ),
    BlocProvider<MaterialCubit>(
      create: (context) => materialCubit,
    ),
    BlocProvider<WorkCubit>(
      create: (context) => workCubit,
    ),
  ];

  AppCubits._privateContructorl();
  
  static final AppCubits _instance = AppCubits._privateContructorl();
  
  factory AppCubits() {
    return _instance;
  }
}
