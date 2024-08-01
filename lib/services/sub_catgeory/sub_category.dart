import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategory {
  static Future<bool> addSubcategory(String categoryId,
      Map<String, dynamic> subcategoryInfo, String subcategoryId) async {
    try {
      DocumentReference categoryDoc = FirebaseFirestore.instance
          .collection('CatgeoryDetails')
          .doc(categoryId);
      await categoryDoc
          .collection('SubCategories')
          .doc(subcategoryId)
          .set(subcategoryInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> subcategoryInfo(
      {required String id,
      required String catName,
      required String catDes,
      required Map<String,dynamic> checkBox,
      required int catPrice,
      required String catImage}) {
    Map<String, dynamic> subcategoryInfo = {
      
      'Id': id,
      'CatName': catName,
      'CatDes': catDes,
      'CatPrice': catPrice,
      'CatImage': catImage,
      'CheckBox':checkBox
    };
    return subcategoryInfo;
  }
}
