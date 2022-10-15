import 'package:flutter/material.dart';

import '../../../models/university.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.universities,
    required this.onTap,
  }) : super(key: key);

  final List<University> universities;
  final Function(University) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final university = universities[index];
        return ListTile(
          title: Text(university.name),
          onTap: () => onTap(university),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 0.0, thickness: 0.7);
      },
      itemCount: universities.length,
    );
  }
}
