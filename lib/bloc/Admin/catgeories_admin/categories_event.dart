part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}
final class ImageChanges extends CategoriesEvent{
final String image;
ImageChanges(this.image);
}
final class TextChanges extends CategoriesEvent{
  final String text;
  TextChanges(this.text);
}
final class FormSubmit extends CategoriesEvent{
  
}