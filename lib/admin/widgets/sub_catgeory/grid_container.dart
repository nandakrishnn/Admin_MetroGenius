// ignore: must_be_immutable
import 'package:adminmetrogenius/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubCatgeoryContainer extends StatelessWidget {
  String catgeoryImage;
  int categoryPrice;
  String categoryDes;
  String categoryHeading;
   SubCatgeoryContainer({
   required this.categoryPrice,
    required this.categoryDes,
     required this.categoryHeading,
     required this.catgeoryImage,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 248, 244, 244)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 188, 178, 178),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  AppConstants.kheight5,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      catgeoryImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                 AppConstants.kwidth10,
                       AppConstants.kwidth5,
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryHeading,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Price From',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        AppConstants.kheight10,
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          width: 100,
                          child: Center(
                            child: Text(
                              '₹ ${categoryPrice}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                categoryDes,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}