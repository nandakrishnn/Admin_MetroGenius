part of 'categories_bloc.dart';

enum UploadStatus { inital, pending, sucess, error }

@immutable
class CategoriesState {
  CategoriesState({
    this.uploadStatus = UploadStatus.inital,
    this.text,
    this.image,
    
  });
  final UploadStatus uploadStatus;
  final String? text;
  final String? image;

  CategoriesState copywith({
UploadStatus?uploadStatus,
final String?image,
final String? text,

  })=>CategoriesState(
    uploadStatus: uploadStatus??this.uploadStatus,
    text: text??this.text,
    image: image??this.image,
  );
}
