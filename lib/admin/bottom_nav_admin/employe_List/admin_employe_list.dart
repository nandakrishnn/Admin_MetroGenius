import 'package:adminmetrogenius/admin/bottom_nav_admin/employe_List/details_employe.dart';
import 'package:adminmetrogenius/admin/widgets/textfeild.dart';
import 'package:adminmetrogenius/animations/route_animations.dart';
import 'package:adminmetrogenius/bloc/Admin/employes_list/employes_list_bloc.dart';
import 'package:adminmetrogenius/bloc/cubit/cubit/search_bar_cubit_cubit.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final showAppBar = screenWidth > 600; // Adjust the width as needed
    return BlocProvider(
      create: (context) => SearchBarCubitCubit(),
      child: BlocConsumer<EmployesListBloc, EmployesListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is EmployesListLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  radius: 12,
                ),
              );
            } else if (state is EmployesListLoaded) {
              final data = state.data;
              return Scaffold(
                appBar: showAppBar
                    ? AppBar(
                        title: const Text('Employee List'),
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        actions: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.sort)),
                          BlocConsumer<SearchBarCubitCubit, SearchBarState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<SearchBarCubitCubit>()
                                        .toggleSearchbar();
                                  },
                                  icon: const Icon(Icons.search));
                            },
                          )
                        ],
                      )
                    : null,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<SearchBarCubitCubit, SearchBarState>(
                        builder: (context, state) {
                          return state is SearchBarVisible? CustomTextFeild(
                            hinttext: 'Search',
                            obscure: false,
                            prefixIcon: Icon(Icons.search),
                          ):SizedBox.shrink();
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            if (data.isEmpty) {
                              return const Center(
                                child: Text('Currently No Employees'),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(DetailsEmploye(
                                    data: data,
                                  )));
                                },
                                child: EmployeeListAdminContainer(
                                  employeName: data[index]['ApplicantName'],
                                  imageUrl: data[index]['ApplicantImage'],
                                  job: data[index]['ApplicantWorkType'],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}

// ignore: must_be_immutable
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
              AppConstants.kheight10
            ],
          )
        ],
      ),
    );
  }
}
