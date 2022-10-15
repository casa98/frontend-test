import 'package:flutter/material.dart';

import '../../models/university.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.university,
  }) : super(key: key);

  final University university;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Details'),
      ),
    );
  }
}
