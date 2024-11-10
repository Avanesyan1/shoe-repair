import 'package:equatable/equatable.dart';
import 'package:shoe_repair/models/shoe_model.dart';

abstract class ShoeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShoeInit extends ShoeState{}
class ShoeLoading extends ShoeState{}
class ShoeLoaded extends ShoeState{
  final ShoeModel shoe;

  ShoeLoaded(this.shoe);

  @override
  List<Object> get props => [shoe]; 
}