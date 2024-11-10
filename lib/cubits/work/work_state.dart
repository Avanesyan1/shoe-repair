import 'package:equatable/equatable.dart';
import 'package:shoe_repair/models/work_model.dart';

abstract class WorkState extends Equatable {
  @override
  List<Object> get props => [];
}

class WorkInit extends WorkState{}
class WorkLoading extends WorkState{}
class WorkLoaded extends WorkState{
  final WorkModel work;

  WorkLoaded(this.work);

  @override
  List<Object> get props => [work]; 
}