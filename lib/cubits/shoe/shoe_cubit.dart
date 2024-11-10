import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/shoe/shoe_state.dart';
import 'package:shoe_repair/models/shoe_model.dart';

class ShoeCubit extends Cubit<ShoeState> {
  ShoeCubit() : super(ShoeInit());

  ShoeModel? shoe;

  void setShoe(ShoeModel newShoe){
    shoe = newShoe;
  }

  void getShoe(){
    if (shoe != null) {
      emit(ShoeLoaded(shoe!));
    }
  }
}