part of 'application_listing_bloc.dart';

abstract class ApplicationListingEvent extends Equatable {
  const ApplicationListingEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends ApplicationListingEvent {}

class DataFetched extends ApplicationListingEvent {
  final List<DocumentSnapshot> data;

  DataFetched(this.data);

  @override
  List<Object> get props => [data];
}
