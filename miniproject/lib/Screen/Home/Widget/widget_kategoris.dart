import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Component/pilihan.dart';

class KategorisWidget extends StatelessWidget {
  final dynamic image;
  final String categoriesName;

  const KategorisWidget({Key? key, required this.categoriesName, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PilihanBerita(name: categoriesName)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: 120,
                height: 65,
              ),
            ),
            Container(
              width: 120,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoriesName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
