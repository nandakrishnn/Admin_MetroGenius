import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServices{


  Future<Stream<QuerySnapshot>>getJobApplications()async{
   return  FirebaseFirestore.instance.collection("EmployeApplications").snapshots();
  }
  Future<Stream<QuerySnapshot>>getCategoryAdmin()async{
   return  FirebaseFirestore.instance.collection("CatgeoryDetails").snapshots();
  }
   Future<Stream<QuerySnapshot>>getEmployeeAdmin()async{
   return  FirebaseFirestore.instance.collection("EmployeesList").snapshots();
  }

}