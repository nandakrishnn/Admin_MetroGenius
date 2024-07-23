part of 'get_category_bloc.dart';

abstract class GetCategoryEvent extends Equatable {
  const GetCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCategory extends GetCategoryEvent {}

class DataFetched extends GetCategoryEvent {
  final List<DocumentSnapshot> data;

  DataFetched(this.data);

  @override
  List<Object> get props => [data];
}
