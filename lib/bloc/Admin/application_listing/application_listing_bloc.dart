import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../services/admin/applications/admin_services.dart';
part   'application_listing_event.dart';
part    'application_listing_state.dart';

class ApplicationListingBloc
    extends Bloc<ApplicationListingEvent, ApplicationListingState> {
  final AdminServices adminServices;

  ApplicationListingBloc(this.adminServices)
      : super(ApplicationListingInitial()) {
    on<FetchData>(_onFetchData);
    on<DataFetched>(_onDataFetched);
    
  }

  Future<void> _onFetchData(FetchData event, Emitter<ApplicationListingState> emit) async {
    emit(ApplicationListingLoading());
    try {
      Stream<QuerySnapshot> dataStream = await adminServices.getJobApplications();
      dataStream.listen((snapshot) {
        final data = snapshot.docs;
        add(DataFetched(data));
      });
    } catch (e) {
      emit(ApplicationListingFailure(e.toString()));
    }
  }

  void _onDataFetched(DataFetched event, Emitter<ApplicationListingState> emit) {
    emit(ApplicationListingLoaded(event.data));
  }
}
