part of 'get_category_bloc.dart';
abstract class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

class GetCategoryStateInitial extends GetCategoryState {}

class GetCategoryStateLoading extends GetCategoryState {}

class GetCategoryStateLoaded extends GetCategoryState {
  final List<DocumentSnapshot> data;

  const GetCategoryStateLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class GetCategoryStateFailure extends GetCategoryState {
  final String error;

  const GetCategoryStateFailure(this.error);

  @override
  List<Object> get props => [error];
}
