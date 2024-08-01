import 'dart:convert';

import 'package:adminmetrogenius/admin/bottom_nav_admin/category/main/catgeory_details.dart';
import 'package:adminmetrogenius/admin/functions/project_functions.dart';
import 'package:adminmetrogenius/admin/widgets/second_formfeild.dart';
import 'package:adminmetrogenius/bloc/Admin/subcategory_addition/add_sub_categories_bloc.dart';
import 'package:adminmetrogenius/services/admin/converters/image_converter.dart';
import 'package:adminmetrogenius/utils/colors.dart';
import 'package:adminmetrogenius/utils/constants.dart';
import 'package:adminmetrogenius/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubcategory extends StatelessWidget {
  dynamic categoryId;
  AddSubcategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {

    TextEditingController subCatgeoryName = TextEditingController();
    TextEditingController subCatgeoryAmount = TextEditingController();
    TextEditingController subCatgeoryDescription = TextEditingController();
    // TextEditingController subCatgeoryRating = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? subCatgeoryImage;
      final  Map<String, bool> checkbox = {
      'Consultation': false,
      'Repair': false,
      'Maintanance': false,
      'Installation':false,
      'Repair and Maintanace':false,


    };
    return BlocConsumer<AddSubCategoriesBloc, AddSubCategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Subcatgeory details'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image =
                            await ProjectFunctionalites().pickImageWeb();
                        if (image != null) {
                          subCatgeoryImage = image;
                        }
                        context
                            .read<AddSubCategoriesBloc>()
                            .add(ImageChnagesSubCatgeory(subCatgeoryImage!));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.greyColor,
                                    offset: Offset(0, 0),
                                    spreadRadius: 4,
                                    blurRadius: 5)
                              ],
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black12,
                            ),
                            height: 200,
                            width: 200,
                            child: subCatgeoryImage != null
                                ? Image.memory(
                                    base64Decode(
                                      subCatgeoryImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://static.vecteezy.com/system/resources/previews/026/631/445/non_2x/add-photo-icon-symbol-design-illustration-vector.jpg',
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    AppConstants.kheight30,
                    CustomTextFeild2(
                        validator: (p0) => Validators.validateName(p0),
                        onChanged: (p0) => context
                            .read<AddSubCategoriesBloc>()
                            .add(CatNameChanges(subCatgeoryName.text)),
                        heading: 'Subcatgeory Name',
                        controller: subCatgeoryName,
                        hinttext: 'Subcatgeory Name',
                        obscure: false),
                    AppConstants.kheight30,
                    CustomTextFeild2(
                        validator: (p0) => Validators.validateAmount(p0),
                        onChanged: (p0) => context
                            .read<AddSubCategoriesBloc>()
                            .add(CatPriceChnages(
                                int.parse(subCatgeoryAmount.text))),
                        heading: 'Amount',
                        controller: subCatgeoryAmount,
                        hinttext: 'Amount',
                        obscure: false),
                    AppConstants.kheight30,
                    CustomTextFeild2(
                        validator: (p0) => Validators.validateDescription(p0),
                        onChanged: (p0) => context
                            .read<AddSubCategoriesBloc>()
                            .add(CatDesChnages(subCatgeoryDescription.text)),
                        heading: 'Description',
                        controller: subCatgeoryDescription,
                        hinttext: 'Description',
                        obscure: false),

                    AppConstants.kheight30,
                  ...checkbox.keys.map((key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: state.checkboxes[key] ?? false,
                        onChanged: (bool? value) {
                          context
                              .read<AddSubCategoriesBloc>()
                              .add(CheckBoxChecked(key, value ?? false));
                        },
                      );
                    }).toList(),
                    // CustomTextFeild2(
                    //   heading: 'Rating',
                    //     controller: subCatgeoryRating,
                    //     hinttext: 'Rating',
                    //     obscure: false),
                    AppConstants.kheight40,
                    GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            final firstoreImage =
                                await uploadImageToFirebase(subCatgeoryImage!);
                            context
                                .read<AddSubCategoriesBloc>()
                                .add(ImageChnagesSubCatgeory(firstoreImage!));
                            context
                                .read<AddSubCategoriesBloc>()
                                .add(FormSubmit(categoryId));
                            Navigator.of(context).pop();
                          }
                        },
                        child: LoginContainer(
                          content: 'Submit',
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
