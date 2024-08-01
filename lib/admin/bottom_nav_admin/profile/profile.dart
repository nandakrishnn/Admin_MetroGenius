import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
      children: [
        Container(
            child: Row(
              children: [
                Container(
                  color: Colors.green,
                  height: 180,width: double.infinity,)
              ]
            ),
          )
      ],
      ),
    );
  }
}