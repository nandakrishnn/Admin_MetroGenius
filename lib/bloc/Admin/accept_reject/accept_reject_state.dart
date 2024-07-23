part of 'accept_reject_bloc.dart';

enum FormStatusReject { inital, pending, sucess, error }

enum FormStatusAccpet { inital, pending, sucess, error }

@immutable
class AcceptRejectState {
  AcceptRejectState({
    this.rejectstatus = FormStatusReject.inital,
    this.acceptstatus = FormStatusAccpet.inital,
  });
  final FormStatusReject rejectstatus;
  final FormStatusAccpet acceptstatus;
  AcceptRejectState copywith({
    FormStatusReject? rejectstatus,
    FormStatusAccpet? acceptstatus,
  }) =>
      AcceptRejectState(
          rejectstatus: rejectstatus ?? this.rejectstatus,
          acceptstatus: acceptstatus ?? this.acceptstatus);
}
