import 'package:adminmetrogenius/admin/bottom_nav_admin/category/add_subcategory.dart';
import 'package:adminmetrogenius/admin/widgets/sub_catgeory/grid_container.dart';
import 'package:adminmetrogenius/animations/route_animations.dart';
import 'package:adminmetrogenius/bloc/Admin/get_subcategory/get_sub_catgeory_data_bloc.dart';
import 'package:adminmetrogenius/services/admin/applications/admin_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCatgeoryAdmin extends StatelessWidget {
  final data;
  const SubCatgeoryAdmin({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSubCatgeoryDataBloc(AdminServices())
        ..add(FetchSubCategoryData(data['Id'])),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Sub Catgeories'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(createRoute(AddSubcategory(
                      categoryId: data['Id'],
                    )));
                  },
                  icon: const Icon(Icons.add_box))
            ],
          ),
          body: BlocConsumer<GetSubCatgeoryDataBloc, GetSubCatgeoryDataState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetSubCatgeoryDataLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (state is GetSubCatgeoryDataLoaded) {
                  final data = state.data;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Subcatgeories for this category'),
                    );
                  }
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 410,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 270),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return SubCatgeoryContainer(
                          categoryPrice: data[index]['CatPrice'],
                          categoryDes: data[index]['CatDes'],
                          categoryHeading: data[index]['CatName'],
                          catgeoryImage: data[index]['CatImage'],
                        );
                      });
                }
                return Container();
              })),
    );
  }
}


// Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: 600,
//                               height: 300,
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Color.fromARGB(255, 188, 178, 178),
//                                     spreadRadius: 1,
//                                     blurRadius: 1,
//                                     offset: Offset(2, 2),
//                                   ),
//                                 ],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Container(
//                                           width: 40,
//                                           height: 40,
//                                           child: Icon(Icons.edit_note),
//                                           decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: Colors.orange,
//                                               border: Border.all(
//                                                 color: Colors.black,
//                                               )),
//                                         ),
//                                         AppConstants.kwidth10,
//                                         Container(
//                                           width: 40,
//                                           height: 40,
//                                           child: Icon(Icons.delete),
//                                           decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: Colors.orange,
//                                               border: Border.all(
//                                                 color: Colors.black,
//                                               )),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 70,
//                                         backgroundImage: NetworkImage(
//                                             data[index]['CatImage']),
//                                       ),
//                                       AppConstants.kheight10,
//                                       Text(data[index]['CatName'],
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black)),
//                                       AppConstants.kheight10,
//                                       Text('Starts From'),
//                                       AppConstants.kheight10,
//                                       Container(
//                                         height: 33,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: Colors.green,
//                                         ),
//                                         width: 70,
//                                         child: Center(
//                                             child: Text(
//                                                 data[index]['CatPrice']
//                                                     .toString(),
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black))),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );






// Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Container(
//                         width: 450,
//                         height: 250,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: AppColors.primaryColor,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Color.fromARGB(255, 188, 178, 178),
//                               spreadRadius: 1,
//                               blurRadius: 2,
//                               offset: Offset(0, 0),
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 60,
//                                     backgroundImage: NetworkImage(
//                                         // data[index]['CatImage']
//                                         ''),
//                                   ),
//                                   AppConstants.kwidth20,
//                                   Column(
//                                     children: [
//                                       Text('AC Check-Up',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black)),
//                                       AppConstants.kheight5,
//                                       Text('Price'),
//                                       AppConstants.kheight5,
//                                       Container(
//                                         height: 33,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: Colors.green,
//                                         ),
//                                         width: 70,
//                                         child: Center(
//                                             child: Text('sdsds'.toString(),
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black))),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           AppConstants.kheight10,
//                                           Text('Description'),
//                                           AppConstants.kheight5,
//                                           Text(
//                                             'Heating, ventilation, and air conditioning (HVAC) technicians install, maintain and repair indoor air quality systems, such as air conditioners ',
//                                             style: TextStyle(
//                                                 fontSize: 13,
//                                                 color: AppColors.greyColor),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ));