import 'package:adminmetrogenius/utils/constants.dart';
import 'package:flutter/material.dart';
class NewNotable extends StatelessWidget {
  final String imageurl;
  final String text;

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
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 188, 178, 178),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              height: 130,
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageurl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Error loading image'));
                  },
                ),
              ),
            ),
            AppConstants.kheight5,
            Text(
              overflow: TextOverflow.ellipsis,
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
