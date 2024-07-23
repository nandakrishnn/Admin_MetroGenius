import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'employes_list_event.dart';
part 'employes_list_state.dart';

class EmployesListBloc extends Bloc<EmployesListEvent, EmployesListState> {
  final AdminServices adminServices;
  EmployesListBloc(this.adminServices) : super(EmployesListInital()) {
   on<FetchEmployeData>(_onFetchData);
   on<DataFetched>(_onDataFetched);
  
  }
  Future<void>_onFetchData(FetchEmployeData event,Emitter<EmployesListState>emit)async{
     emit(EmployesListLoading());
     try {
       Stream<QuerySnapshot>dataStream=await adminServices.getEmployeeAdmin();
       dataStream.listen((snapshot){
        final data=snapshot.docs;
        add( DataFetched(data));
       });

     } catch (e) {
       emit(EmployesListFailure(e.toString()));
     }
  }

  void _onDataFetched(DataFetched event,Emitter<EmployesListState>emit)async{
     emit(EmployesListLoaded(event.data));
  }
}
