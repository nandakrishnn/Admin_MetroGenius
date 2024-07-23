part of 'employes_list_bloc.dart';

abstract class EmployesListState extends Equatable {
  const EmployesListState();

  @override
  List<Object> get props => [];
}

class EmployesListInital extends EmployesListState {}

class EmployesListLoading extends EmployesListState {}

class EmployesListLoaded extends EmployesListState {
  final List<DocumentSnapshot> data;
  const EmployesListLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class EmployesListFailure extends EmployesListState {
  final String error;
  EmployesListFailure(this.error);
  @override
  List<Object> get props => [error];
}
