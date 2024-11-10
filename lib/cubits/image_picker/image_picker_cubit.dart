import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_repair/cubits/image_picker/image_picker_state.dart';
import 'package:shoe_repair/widgets/pickers/picke_image_source.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        emit(ImagePickerSelected(File(pickedFile.path)));
      }
    } catch (error) {
      emit(ImagePickerError("Failed to pick image: $error"));
    }
  }

  Future<void> showImageSourceSelector(BuildContext context) async {
    final selectedSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return const PickeImageSource();
      },
    );

    if (selectedSource != null) {
      await pickImage(selectedSource);
    }
  }
}
