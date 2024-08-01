import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:html' as html; // Ensure this import is present
import 'dart:typed_data';


Future<String?> uploadImageToFirebase(String base64Image) async {
  try {
    final imageBytes = base64Decode(base64Image);
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';
    final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

    final uploadTask = storageRef.putData(Uint8List.fromList(imageBytes));
    final taskSnapshot = await uploadTask;

    final downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}



