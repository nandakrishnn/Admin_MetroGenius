part of 'add_sub_categories_bloc.dart';

enum SubCatFormStatus { inital, pending, sucess, failure }

class AddSubCategoriesState {
  AddSubCategoriesState(
      {this.catName = '',
      this.catDescription = '',
      this.catPrice,
  this.checkboxes = const {},
      this.catImage,
      this.status = SubCatFormStatus.inital});
  String? catImage;
  String? catName;
  String? catDescription;
  int? catPrice;
  final Map<String, bool> checkboxes;
  final SubCatFormStatus status;

  AddSubCategoriesState copyWith({
    String? catImage,
    String? catName,
    String? catDescription,
    int? catPrice,
 Map<String, bool>? checkboxes,
      final SubCatFormStatus? status
  }) =>
      AddSubCategoriesState(
        checkboxes: checkboxes??this.checkboxes,
          catImage: catImage ?? this.catImage,
          catName: catName ?? this.catName,
          catDescription: catDescription ?? this.catDescription,
          catPrice: catPrice ?? this.catPrice,
          status: status ?? this.status);
}
