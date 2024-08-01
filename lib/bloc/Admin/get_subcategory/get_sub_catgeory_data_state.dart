part of 'get_sub_catgeory_data_bloc.dart';

sealed class GetSubCatgeoryDataState extends Equatable {
  const GetSubCatgeoryDataState();
  
  @override
  List<Object> get props => [];
}

 class GetSubCatgeoryDataInitial extends GetSubCatgeoryDataState {}
 class GetSubCatgeoryDataLoading extends GetSubCatgeoryDataState {}
 class GetSubCatgeoryDataLoaded extends GetSubCatgeoryDataState {
 
    final List<DocumentSnapshot>data;
    GetSubCatgeoryDataLoaded(this.data);
  @override
  List<Object> get props => [data];
}
 class GetSubCatgeoryDataFailure extends GetSubCatgeoryDataState {
final  String errorMsg;
GetSubCatgeoryDataFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}