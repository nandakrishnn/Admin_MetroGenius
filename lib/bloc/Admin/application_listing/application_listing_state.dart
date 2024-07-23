part of 'application_listing_bloc.dart';

abstract class ApplicationListingState extends Equatable {
  const ApplicationListingState();

  @override
  List<Object> get props => [];
}

class ApplicationListingInitial extends ApplicationListingState {}

class ApplicationListingLoading extends ApplicationListingState {}

class ApplicationListingLoaded extends ApplicationListingState {
  final List<DocumentSnapshot> data;

  const ApplicationListingLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ApplicationListingFailure extends ApplicationListingState {
  final String error;

  const ApplicationListingFailure(this.error);

  @override
  List<Object> get props => [error];
}
