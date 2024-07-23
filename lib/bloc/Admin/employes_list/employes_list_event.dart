part of 'employes_list_bloc.dart';

sealed class EmployesListEvent extends Equatable {
  const EmployesListEvent();

  @override
  List<Object> get props => [];
}
class FetchEmployeData extends EmployesListEvent{}

class DataFetched extends EmployesListEvent{
  final List<DocumentSnapshot>data;
  DataFetched(this.data);
  @override
 List<Object>get props=>[data];
}
