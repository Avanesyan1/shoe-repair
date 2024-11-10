import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/data/data_state.dart';
import 'package:shoe_repair/models/material_model.dart';
import 'package:shoe_repair/models/shoe_model.dart';
import 'package:shoe_repair/models/work_model.dart';
import 'package:shoe_repair/services/database_service.dart';

class DataCubit extends Cubit<DataState> {
  final DatabaseService dbService = DatabaseService();

  DataCubit() : super(DataInit());

  List<MaterialModel> materials = [];
  List<WorkModel> works = [];
  List<ShoeModel> shoes = [];

  Future<void> loadData() async {
    emit(DataLoading());
    
    try {
      materials = await dbService.getAllMaterials();
      works = await dbService.getAllWorks();
      shoes = await dbService.getAllShoes();

      emit(DataLoaded(materials, shoes, works));
    } catch (e) {
      log('Error loading data: $e');
    }
  }

  Future<void> addMaterial(MaterialModel material) async {
    try {
      await dbService.addMaterial(material);
      loadData();
    } catch (e) {
      log('Error adding material: $e');
    }
  }

  Future<void> addWork(WorkModel work) async {
    try {
      await dbService.addWork(work);
      loadData();
    } catch (e) {
      log('Error adding work: $e');
    }
  }

  Future<void> addShoe(ShoeModel shoe) async {
    try {
      await dbService.addShoe(shoe);
      loadData();
    } catch (e) {
      log('Error adding shoe: $e');
    }
  }

  Future<void> updateMaterial(int id, MaterialModel material) async {
    try {
      await dbService.updateMaterial(id, material);
      loadData();
    } catch (e) {
      log('Error updating material: $e');
    }
  }

  Future<void> updateWork(int id, WorkModel work) async {
    try {
      await dbService.updateWork(id, work);
      loadData();
    } catch (e) {
      log('Error updating work: $e');
    }
  }

  Future<void> updateShoe(int id, ShoeModel shoe) async {
    try {
      await dbService.updateShoe(id, shoe);
      loadData();
    } catch (e) {
      log('Error updating shoe: $e');
    }
  }

  Future<void> deleteMaterial(int id) async {
    try {
      await dbService.deleteMaterial(id);
      loadData();
    } catch (e) {
      log('Error deleting material: $e');
    }
  }

  Future<void> deleteWork(int id) async {
    try {
      await dbService.deleteWork(id);
      loadData();
    } catch (e) {
      log('Error deleting work: $e');
    }
  }

  Future<void> deleteShoe(int id) async {
    try {
      await dbService.deleteShoe(id);
      loadData();
    } catch (e) {
      log('Error deleting shoe: $e');
    }
  }
}
