import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shoe_repair/models/material_model.dart';
import 'package:shoe_repair/models/work_model.dart';
import 'package:shoe_repair/models/shoe_model.dart';
import 'dart:developer'; 

class DatabaseService {
  static const String _dbName = 'app_database.db';
  static const String _materialTable = 'materialTable';
  static const String _workTable = 'workTable';
  static const String _shoeTable = 'shoeTable';

  static final DatabaseService _instance = DatabaseService._internal();

  DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_materialTable(
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT,
          count INTEGER,
          imagePath TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE $_shoeTable(
          id INTEGER PRIMARY KEY,
          name TEXT,
          brand TEXT,
          model TEXT,
          comment TEXT,
          ownerFullName TEXT,
          phoneNumber TEXT,
          imagePath TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE $_workTable(
          id INTEGER PRIMARY KEY,
          name TEXT,
          submissionDeadline TEXT,
          comment TEXT,
          price INTEGER,
          shoeName TEXT,
          material TEXT
        )
      ''');
    }, onUpgrade: (db, oldVersion, newVersion) async {});
  }

  Future<void> addMaterial(MaterialModel material) async {
    try {
      final db = await _openDatabase();
      await db.insert(_materialTable, material.toMap());
    } catch (e) {
      log('Error adding material: $e');
    }
  }

  Future<List<MaterialModel>> getAllMaterials() async {
    try {
      final db = await _openDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_materialTable);
      return List.generate(maps.length, (i) {
        return MaterialModel.fromMap(maps[i]);
      });
    } catch (e) {
      log('Error fetching materials: $e');
      return [];
    }
  }

  Future<void> updateMaterial(int id, MaterialModel material) async {
    try {
      final db = await _openDatabase();
      await db.update(
        _materialTable,
        material.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error updating material: $e');
    }
  }

  Future<void> deleteMaterial(int id) async {
    try {
      final db = await _openDatabase();
      await db.delete(
        _materialTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error deleting material: $e');
    }
  }

  Future<void> addWork(WorkModel work) async {
    try {
      final db = await _openDatabase();
      await db.insert(_workTable, work.toMap());
    } catch (e) {
      log('Error adding work: $e');
    }
  }

  Future<List<WorkModel>> getAllWorks() async {
    try {
      final db = await _openDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_workTable);
      return List.generate(maps.length, (i) {
        return WorkModel.fromMap(maps[i]);
      });
    } catch (e) {
      log('Error fetching works: $e');
      return [];
    }
  }

  Future<void> updateWork(int id, WorkModel work) async {
    try {
      final db = await _openDatabase();
      await db.update(
        _workTable,
        work.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error updating work: $e');
    }
  }

  Future<void> deleteWork(int id) async {
    try {
      final db = await _openDatabase();
      await db.delete(
        _workTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error deleting work: $e');
    }
  }

  Future<void> addShoe(ShoeModel shoe) async {
    try {
      final db = await _openDatabase();
      await db.insert(_shoeTable, shoe.toMap());
    } catch (e) {
      log('Error adding shoe: $e');
    }
  }

  Future<List<ShoeModel>> getAllShoes() async {
    try {
      final db = await _openDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_shoeTable);
      return List.generate(maps.length, (i) {
        return ShoeModel.fromMap(maps[i]);
      });
    } catch (e) {
      log('Error fetching shoes: $e');
      return [];
    }
  }

  Future<void> updateShoe(int id, ShoeModel shoe) async {
    try {
      final db = await _openDatabase();
      await db.update(
        _shoeTable,
        shoe.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error updating shoe: $e');
    }
  }

  Future<void> deleteShoe(int id) async {
    try {
      final db = await _openDatabase();
      await db.delete(
        _shoeTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error deleting shoe: $e');
    }
  }
}
