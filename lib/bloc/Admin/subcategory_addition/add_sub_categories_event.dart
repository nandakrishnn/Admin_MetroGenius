part of 'add_sub_categories_bloc.dart';

sealed class AddSubCategoriesEvent {}
final class ImageChnagesSubCatgeory extends AddSubCategoriesEvent {
  final String image;
  ImageChnagesSubCatgeory(this.image);
}
final class CatNameChanges extends AddSubCategoriesEvent{
  final String CatName;
  CatNameChanges(this.CatName);
}
final class CatDesChnages extends AddSubCategoriesEvent{
  final String catDes;
  CatDesChnages(this.catDes);
}
final class CatPriceChnages extends AddSubCategoriesEvent{
  final int catPrice;
  CatPriceChnages(this.catPrice);
}
final class CheckBoxChecked extends AddSubCategoriesEvent{
  final String id; // Unique identifier of the checkbox
  final bool isChecked;
  CheckBoxChecked(this.id, this.isChecked);
}
final class FormSubmit extends AddSubCategoriesEvent{
  final String categoryId;
  FormSubmit(this.categoryId);
}