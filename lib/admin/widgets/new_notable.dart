import 'package:flutter/material.dart';

class NewNotable extends StatelessWidget {
  String imageurl;
  String text;
  NewNotable({
    required this.imageurl,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Container(
        height: 150,
        width: 130,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: .5,
                    blurRadius: .5,
                    offset: Offset(0, 0)
                  )
                ]
              ),
              height: 130,
              width: 130,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageurl,
                    fit: BoxFit.cover,
                  )),
            ),
  
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}




