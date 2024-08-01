import 'package:adminmetrogenius/admin/bottom_nav_admin/category/main/catgeory_details.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/category/sub_catgeory_admin.dart';
import 'package:adminmetrogenius/admin/widgets/new_notable.dart';
import 'package:adminmetrogenius/admin/widgets/textfeild.dart';
import 'package:adminmetrogenius/animations/route_animations.dart';
import 'package:adminmetrogenius/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:adminmetrogenius/bloc/cubit/cubit/search_bar_cubit_cubit.dart';
import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:adminmetrogenius/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryAdmin extends StatelessWidget {
  const AddCategoryAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final showAppBar = screenWidth > 600; 
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetCategoryBloc(AdminServices())..add(FetchDataCategory()),
        ),
        BlocProvider(
          create: (context) => SearchBarCubitCubit(),
        ),
      ],
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                elevation: 0,
                actions: [
                  BlocConsumer<SearchBarCubitCubit, SearchBarState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            context
                                .read<SearchBarCubitCubit>()
                                .toggleSearchbar();
                          },
                          icon: Icon(Icons.search));
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(createRoute(const AddCatgeoryDetails()));
                      },
                      icon: Icon(Icons.add_box_outlined))
                ],
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text('Add Catgeories'),
              )
            : null,
        body: BlocConsumer<GetCategoryBloc, GetCategoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetCategoryStateLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(
                animating: true,
              ));
            }
            if (state is GetCategoryStateLoaded) {
              final data = state.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    BlocConsumer<SearchBarCubitCubit, SearchBarState>(
                      listener: (context, state) {
                       
                      },
                      builder: (context, state) {
                        return state is SearchBarVisible? CustomTextFeild(
                          hinttext: 'Search',
                          obscure: false,
                          prefixIcon: Icon(Icons.search),
                        ):SizedBox.shrink();
                      },
                    ),
                    AppConstants.kheight20,
                    Expanded(
                      child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 160,
                                  crossAxisSpacing: 9,
                                  mainAxisSpacing: 11,
                                  maxCrossAxisExtent: 140),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(SubCatgeoryAdmin(
                                    data:data[index],
                                  )));
                                },
                                child: NewNotable(
                                    imageurl: data[index]['CategoryImage'],
                                    text: data[index]['CatgeoryName']));
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
