import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerSelected extends ImagePickerState {
  final File image;

  const ImagePickerSelected(this.image);

  @override
  List<Object> get props => [image];
}

class ImagePickerError extends ImagePickerState {
  final String message;

  const ImagePickerError(this.message);

  @override
  List<Object> get props => [message];
}
