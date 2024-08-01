part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}
final class ImageChangesCategory extends CategoriesEvent{
final String image;
ImageChangesCategory(this.image);
}
final class TextChanges extends CategoriesEvent{
  final String text;
  TextChanges(this.text);
}
final class FormSubmit extends CategoriesEvent{
  
}