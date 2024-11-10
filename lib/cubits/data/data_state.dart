import 'package:equatable/equatable.dart';
import 'package:shoe_repair/models/material_model.dart';
import 'package:shoe_repair/models/shoe_model.dart';
import 'package:shoe_repair/models/work_model.dart';

abstract class DataState extends Equatable{
  @override
  List<Object> get props => [];
}

class DataInit extends DataState{}

class DataLoading extends DataState{}

class DataLoaded extends DataState{
  final List<MaterialModel> materials;
  final List<WorkModel> works;
  final List<ShoeModel> shoes;

  DataLoaded(this.materials, this.shoes, this.works);

  @override
  List<Object> get props => [materials, works, shoes];
}