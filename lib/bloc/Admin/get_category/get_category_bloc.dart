import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
   final AdminServices adminServices;

  GetCategoryBloc(this.adminServices)
      : super(GetCategoryStateInitial()) {
    on<FetchDataCategory>(_onFetchData);
    on<DataFetched>(_onDataFetched);
    
  }

  Future<void> _onFetchData(FetchDataCategory event, Emitter<GetCategoryState> emit) async {
    emit(GetCategoryStateLoading());
    try {
      Stream<QuerySnapshot> categoryStream = await adminServices.getCategoryAdmin();
      categoryStream.listen((snapshot) {
        final data = snapshot.docs;
        add(DataFetched(data));
      });
    } catch (e) {
      emit(GetCategoryStateFailure(e.toString()));
    }
  }

  void _onDataFetched(DataFetched event, Emitter<GetCategoryState> emit) {
    emit(GetCategoryStateLoaded(event.data));
  }
}
