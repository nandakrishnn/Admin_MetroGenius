import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsEmploye extends StatelessWidget {
  final data;
  const DetailsEmploye({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}