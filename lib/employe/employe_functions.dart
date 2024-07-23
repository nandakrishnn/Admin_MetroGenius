import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeJobApplication {
  //This is used for the submission of a job application
  Future<bool> addEmployeApplications(
      Map<String, dynamic> employeeApplicationInfo, dynamic id) async {
    try {
      await FirebaseFirestore.instance
          .collection("EmployeApplications")
          .doc(id)
          .set(employeeApplicationInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> employeApplicationsInfo(
      {required String id,
      required String img,
      required String name,
      required int phone,
      required String email,
      required String work,
      required int experi,
      required String proof}) {
    Map<String, dynamic> employeeApplicationInfo = {
      'Id': id,
      'ApplicantImage': img,
      'ApplicantName': name,
      'ApplicantPhone': phone,
      'ApplicantEmail': email,
      'ApplicantWorkType': work,
      'ApplicantExperience': experi,
      'ApplicantProof': proof
    };
    return employeeApplicationInfo;
  }

  Future<bool> deleteCategory(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("EmployeApplications")
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> acceptEmployeAsWorker(
      Map<String, dynamic> accepctedEmployeeInfo, dynamic id) async {
    try {
      await FirebaseFirestore.instance
          .collection("EmployeesList")
          .doc(id)
          .set(accepctedEmployeeInfo).whenComplete(

              deleteCategory(id) as FutureOr<void> Function()
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> accepctedEmployeeInfo(DocumentSnapshot<Object?>data)

   {
    Map<String, dynamic> accepctedEmployeeInfo = {
      'Id': data['Id'],
      'ApplicantImage': data['ApplicantImage'],
      'ApplicantName': data['ApplicantName'],
      'ApplicantPhone': data['ApplicantPhone'],
      'ApplicantEmail': data['ApplicantEmail'],
      'ApplicantWorkType': data['ApplicantWorkType'],
      'ApplicantExperience': data['ApplicantExperience'],
      'ApplicantProof': data['ApplicantProof']
    };
    return accepctedEmployeeInfo;
  }



  //add category admin

    Future<bool> addCatgeoryAdmin(
      Map<String, dynamic> adminCatgeoryInfo, dynamic id) async {
    try {
      await FirebaseFirestore.instance
          .collection("CatgeoryDetails")
          .doc(id)
          .set(adminCatgeoryInfo).whenComplete(

              deleteCategory(id) as FutureOr<void> Function()
          );
      return true;
    } catch (e) {
      return false;
    }
  }
   
  Map<String, dynamic> adminCatgeoryInfo(
      {required String id,
      required String img,
      required String name,
    }) {
    Map<String, dynamic> adminCatgeoryInfo = {
      'Id': id,
      'CategoryImage': img,
      'CatgeoryName': name,
    
    };
    return adminCatgeoryInfo;
  }

}
