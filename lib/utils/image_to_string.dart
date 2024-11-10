import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<String> saveImageLocally(Uint8List imageBytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);
  
  await file.writeAsBytes(imageBytes);
  
  return file.path; 
}