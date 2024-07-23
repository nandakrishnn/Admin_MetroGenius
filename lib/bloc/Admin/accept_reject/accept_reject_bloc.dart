import 'package:adminmetrogenius/employe/employe_functions.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'accept_reject_event.dart';
part 'accept_reject_state.dart';

class AcceptRejectBloc extends Bloc<AcceptRejectEvent, AcceptRejectState> {
  AcceptRejectBloc() : super(AcceptRejectState()) {
    on<Accepted>(_accepted);
    on<Rejected>(_rejected);
  }
  void _accepted(Accepted event, Emitter<AcceptRejectState> emit) async {
    emit(state.copywith(acceptstatus: FormStatusAccpet.pending));
    try {
      final employeeAddedMap =
          EmployeJobApplication().accepctedEmployeeInfo(event.data);
      final employeAdded = await EmployeJobApplication()
          .acceptEmployeAsWorker(employeeAddedMap, employeeAddedMap['Id']);
          if(employeAdded){
            emit(state.copywith(acceptstatus: FormStatusAccpet.sucess));
          }else{
            emit(state.copywith(acceptstatus: FormStatusAccpet.error));
          }
    } catch (e) {
        emit(state.copywith(acceptstatus: FormStatusAccpet.error));
    }
  }

  void _rejected(Rejected event, Emitter<AcceptRejectState> emit) async {
    emit(state.copywith(rejectstatus: FormStatusReject.pending));
    try {
      final rejected = await EmployeJobApplication().deleteCategory(event.id);
      if (rejected==true) {
        emit(state.copywith(rejectstatus: FormStatusReject.sucess));
      } else {
        emit(state.copywith(rejectstatus: FormStatusReject.error));
      }
    } catch (e) {
      emit(state.copywith(rejectstatus: FormStatusReject.error));
    }
  }
}
