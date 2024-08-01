import 'dart:io';

import 'package:adminmetrogenius/admin/applicant_details/details_applicant.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/employe_List/admin_employe_list.dart';
import 'package:adminmetrogenius/admin/widgets/textfeild.dart';
import 'package:adminmetrogenius/animations/route_animations.dart';
import 'package:adminmetrogenius/bloc/Admin/application_listing/application_listing_bloc.dart';
import 'package:adminmetrogenius/bloc/cubit/cubit/search_bar_cubit_cubit.dart';
import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:adminmetrogenius/utils/colors.dart';
import 'package:adminmetrogenius/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicantDeatils extends StatelessWidget {
  TextEditingController queryController=TextEditingController();
 late final List< DocumentSnapshot >doc1;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ApplicationListingBloc(AdminServices())..add(FetchData()),
        ),
        BlocProvider(
          create: (context) => SearchBarCubitCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Job Applications',
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<SearchBarCubitCubit, SearchBarState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                        context.read<SearchBarCubitCubit>().toggleSearchbar();
                    }, icon: Icon(Icons.search_rounded));
              },
            )
          ],
        ),
        body: BlocConsumer<ApplicationListingBloc, ApplicationListingState>(
          listener: (context, state) {
            if (state is ApplicationListingFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: //${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is ApplicationListingLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is ApplicationListingLoaded) {
              if (state.data.isEmpty) {
                return Center(
                    child: Container(
                  child: Text('No Applications'),
                ));
              }
              final data = state.data;
             doc1=data;
              return Column(
                children: [
                  Column(
                    children: [
                         BlocBuilder<SearchBarCubitCubit, SearchBarState>(
                    builder: (context, state) {
                      return state is SearchBarVisible
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CustomTextFeild(hinttext: 'Search',obscure: false,
                              controller: queryController,
                              onChanged: (p0) {
                                
                              },
                              )
                            )
                          : SizedBox.shrink();
                    },
                  ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.people),
                                  Text(
                                    " Job Applications",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              AppConstants.kheight5,
                              Text('Total applicaitons recieved ' +
                                        '(${data.length})',  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.greyColor
                                    ),)
                            ],
                          )),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top:0, bottom: 0),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final doc = data[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(createRoute(ApplicantDetails(
                                  data: doc,
                                )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ApplicantListAdminContainer(
                                  employeName: doc['ApplicantName'],
                                  imageUrl: doc['ApplicantImage'],
                                  job: doc['ApplicantWorkType'],
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
  search(String query){
   
  }
}
class ApplicantListAdminContainer extends StatelessWidget {
  String employeName;
  String job;
  String imageUrl;
  ApplicantListAdminContainer({
    required this.employeName,
    required this.imageUrl,
    required this.job,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
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
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .1,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              AppConstants.kwidth30,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppConstants.kheight10,
                  Text(
                    employeName,
                    style:
                        const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(job,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor)),
        
                ],
              )
            ],
          ),
        ),
          AppConstants.kwidth20,
      ],
    );
  }
}
