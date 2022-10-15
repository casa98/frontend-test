import 'package:flutter/material.dart';

import '../../../models/university.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.universities,
    required this.onTap,
  }) : super(key: key);

  final List<University> universities;
  final Function(University) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: universities.map((university) {
        return InkWell(
          onTap: () => onTap(university),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              university.name,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          )),
        );
      }).toList(),
    );
  }
}
