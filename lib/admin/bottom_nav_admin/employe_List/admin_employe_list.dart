import 'package:adminmetrogenius/bloc/Admin/employes_list/employes_list_bloc.dart';
import 'package:adminmetrogenius/utils/colors.dart';
import 'package:adminmetrogenius/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmployeeListAdmin extends StatelessWidget {
  const EmployeeListAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EmployesListBloc>()..add(FetchEmployeData());
    return BlocConsumer<EmployesListBloc, EmployesListState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
        if(state is EmployesListLoading){
          return Center(child: CupertinoActivityIndicator(animating: true,radius: 12,),);
        }
       else if(state is EmployesListLoaded){
          final data=state.data;
 return Scaffold(
          appBar: AppBar(
            title: Text('Employee List'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if(data.isEmpty){
                return Center(child: Text('Currently No Employees'),);
              }
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: EmployeeListAdminContainer(
                employeName: data[index]['ApplicantName'],
                imageUrl: data[index]['ApplicantImage'],
                job: data[index]['ApplicantWorkType'],
              ),
            );
          }),
        );
        }return Container();
       
      }
    );
  }
}

class EmployeeListAdminContainer extends StatelessWidget {
  String employeName;
  String job;
  String imageUrl;
   EmployeeListAdminContainer({
   required this.employeName,
   required this.imageUrl,
   required this.job,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 10),
                spreadRadius: 3,
                blurRadius: 10,
                color: Color.fromARGB(249, 193, 203, 222))
          ]),
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              
              child: Image.network(imageUrl,fit: BoxFit.cover,),
              height: MediaQuery.of(context).size.height * .12,
              width: MediaQuery.of(context).size.width * .25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                  ),
            ),
          ),
          AppConstants.kwidth30,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                employeName,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(job,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyColor))
            ],
          )
        ],
      ),
    );
  }
}
