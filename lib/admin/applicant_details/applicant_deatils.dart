import 'dart:io';

import 'package:adminmetrogenius/admin/applicant_details/details_applicant.dart';
import 'package:adminmetrogenius/animations/route_animations.dart';
import 'package:adminmetrogenius/bloc/Admin/application_listing/application_listing_bloc.dart';
import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicantDeatils extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationListingBloc(AdminServices())..add(FetchData()),
      child: Scaffold(
        appBar: AppBar(title: Text('Job Applications'),
        centerTitle: true,
        ),
        body: BlocConsumer<ApplicationListingBloc, ApplicationListingState>(
          listener: (context, state) {
            if (state is ApplicationListingFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
            
          },
          builder: (context, state) {
            if (state is ApplicationListingLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is ApplicationListingLoaded) {
              if(state.data.isEmpty){
                return Center(child: Container(child: Text('No Applications'),));
              }
              final data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final doc = data[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(createRoute(ApplicantDetails(data: doc,)));
                    },
                    child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:NetworkImage(doc['ApplicantImage'])
                    ),
                      
                      title: Text(doc['ApplicantName']),
                      subtitle: Text(doc['ApplicantWorkType']), 
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Something went wrong!'));
            }
            
          },
        ),
      ),
    );
  }
}
