import 'package:equatable/equatable.dart';
import 'package:shoe_repair/models/material_model.dart';

abstract class MateriallState extends Equatable {
  @override
  List<Object> get props => [];
}

class MaterialInit extends MateriallState{}

class MaterialLoading extends MateriallState{}

class MaterialLoaded extends MateriallState{
  final MaterialModel material;

  MaterialLoaded(this.material);

  @override
  List<Object> get props => [material]; 
}