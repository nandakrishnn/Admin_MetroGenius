import 'dart:io';

import 'package:adminmetrogenius/admin/functions/project_functions.dart';
import 'package:adminmetrogenius/admin/widgets/custom_snackbar.dart';
import 'package:adminmetrogenius/admin/widgets/textfeild.dart';
import 'package:adminmetrogenius/bloc/Admin/catgeories_admin/categories_bloc.dart';
import 'package:adminmetrogenius/services/admin/converters/image_converter.dart';
import 'package:adminmetrogenius/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';


class AddCatgeoryDetails extends StatelessWidget {
  const AddCatgeoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController categoryName = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? catgeoryImage;
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppConstants.kheight60,
                    GestureDetector(
                      onTap: () async {
                        final img =
                            await ProjectFunctionalites.imagePickercir();
                        if (img != null) {
                          context
                              .read<CategoriesBloc>()
                              .add(ImageChanges(img.path!));
                          catgeoryImage = img.path;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black12,
                            ),
                            height: 200,
                            width: 200,
                            child: catgeoryImage != null
                                ? Image.file(
                                    File(
                                      catgeoryImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://www.shutterstock.com/image-vector/add-photo-icon-vector-line-260nw-1039350133.jpg',
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    AppConstants.kheight60,
                    CustomTextFeild(
                        controller: categoryName,
                        onChanged: (p0) => context
                            .read<CategoriesBloc>()
                            .add(TextChanges(categoryName.text)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (value.length < 2) {
                            return 'Catgeory Name must be at least 2 characters long';
                          }
                          if (value.length > 50) {
                            return 'Catgeory Name must not exceed 50 characters';
                          }
                          return null;
                        },
                        hinttext: 'Category Name',
                        obscure: false),
                    AppConstants.kheight60,
                    GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (catgeoryImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnack(
                                      'Select Image',
                                      'Select Image to Proceed',
                                      Icon(Icons.error),
                                      Colors.red));
                            }
                            if (catgeoryImage != null) {
                              final image = await uploadImageToFirebase(
                                  File(catgeoryImage!));
                              context
                                  .read<CategoriesBloc>()
                                  .add(ImageChanges(image!));
                              context.read<CategoriesBloc>().add(FormSubmit());
                                Navigator.of(context).pop();
                            }
                          
                          }
                        },
                        child: LoginContainer(content: 'Submit'))
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

class LoginContainer extends StatelessWidget {
  String content;
   LoginContainer({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.mainBlueColor,
          borderRadius: BorderRadius.circular(7)),
      child:  Center(
          child: Text(
        content,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800),
      )),
    );
  }
}
