import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/cubits/image_picker/image_picker_cubit.dart';
import 'package:shoe_repair/cubits/image_picker/image_picker_state.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class ImageZone extends StatelessWidget {
  const ImageZone({
    super.key,
    required this.onImagePicked
  });

  final Function(String) onImagePicked;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        if (state is ImagePickerSelected) {
          onImagePicked(state.image.path);
        }
        return GestureDetector(
          onTap: () async {
            AppCubits.imagePickerCubit.showImageSourceSelector(context);
          },
          child: Container(
            height: size.height * 0.12,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white245
            ),
            child: state is ImagePickerSelected
              ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  state.image,
                  fit: BoxFit.cover,
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    SvgPicture.asset(AppIcons.addPhoto),
                    const Text('Загрузите фотографию\n(необязательно)', style: AppStyles.f12w700Opacity01,)
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}
