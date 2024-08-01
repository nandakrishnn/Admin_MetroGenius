
import 'package:adminmetrogenius/admin/tabbar.dart';
import 'package:adminmetrogenius/bloc/Admin/accept_reject/accept_reject_bloc.dart';
import 'package:adminmetrogenius/bloc/Admin/application_listing/application_listing_bloc.dart';
import 'package:adminmetrogenius/bloc/Admin/catgeories_admin/categories_bloc.dart';
import 'package:adminmetrogenius/bloc/Admin/employes_list/employes_list_bloc.dart';
import 'package:adminmetrogenius/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:adminmetrogenius/bloc/Admin/get_subcategory/get_sub_catgeory_data_bloc.dart';
import 'package:adminmetrogenius/firebase_options.dart';
import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:adminmetrogenius/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/Admin/subcategory_addition/add_sub_categories_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider(create: (context)=>ApplicationListingBloc(AdminServices())),
        BlocProvider(
          create: (context) => AcceptRejectBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
   
        ),
        BlocProvider(
          create: (context) => GetCategoryBloc(AdminServices()),
      
        ),
        BlocProvider(
          create: (context) => EmployesListBloc(AdminServices()),

        ),
        BlocProvider(
          create: (context) => AddSubCategoriesBloc(),

        ),
        BlocProvider(
          create: (context) => GetSubCatgeoryDataBloc(AdminServices()),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          debugShowCheckedModeBanner: false,
          color: AppColors.primaryColor,
          home: AdminBottomNavigation()),
    );
  }
}
