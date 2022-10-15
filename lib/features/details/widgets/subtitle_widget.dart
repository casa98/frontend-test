import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(color: Theme.of(context).primaryColor),
    );
  }
}
