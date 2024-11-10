import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/material/material_state.dart';
import 'package:shoe_repair/models/material_model.dart';

class MaterialCubit extends Cubit<MateriallState> {
  MaterialCubit() : super(MaterialInit());

  MaterialModel? material;

  void setMaterial(MaterialModel newMaterial){
    material = newMaterial;
  }

  void getMaterial(){
    if (material != null) {
      emit(MaterialLoaded(material!));
    }
  }
}