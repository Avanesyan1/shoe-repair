import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/work/work_state.dart';
import 'package:shoe_repair/models/work_model.dart';

class WorkCubit extends Cubit<WorkState> {
  WorkCubit() : super(WorkInit());

  WorkModel? work;

  void setWork(WorkModel newWork){
    work = newWork;
  }

  void getWork(){
    if (work != null) {
      emit(WorkLoaded(work!));
    }
  }
}