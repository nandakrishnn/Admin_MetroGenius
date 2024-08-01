import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'get_sub_catgeory_data_event.dart';
part 'get_sub_catgeory_data_state.dart';

class GetSubCatgeoryDataBloc extends Bloc<GetSubCatgeoryDataEvent, GetSubCatgeoryDataState> {
  final AdminServices adminServices;
  GetSubCatgeoryDataBloc(this.adminServices) : super(GetSubCatgeoryDataInitial()) {
   on<FetchSubCategoryData>(_fetchData);
   on<DataFetchedSubCatgeory>(_onDataFetched);

  }

  Future<void> _fetchData(FetchSubCategoryData event,Emitter<GetSubCatgeoryDataState>emit)async{
    emit(GetSubCatgeoryDataLoading());
    try {
      Stream<QuerySnapshot>catgeoryStream=await adminServices.getSubCategories(event.catgeoryId);
      catgeoryStream.listen((snapshots){
        final data=snapshots.docs;
        add(DataFetchedSubCatgeory(data));
      });
    } catch (e) {
      emit(GetSubCatgeoryDataFailure(e.toString()));
    }
  }
  void _onDataFetched(DataFetchedSubCatgeory event,Emitter<GetSubCatgeoryDataState>emit){
    emit(GetSubCatgeoryDataLoaded(event.data));
  }
}
