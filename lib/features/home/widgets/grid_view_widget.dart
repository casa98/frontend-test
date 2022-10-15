import 'package:flutter/material.dart';

import '../../../models/university.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({
    Key? key,
    required this.universities,
    required this.onLoadMoreUniversities,
    required this.onTap,
  }) : super(key: key);

  final List<University> universities;
  final VoidCallback onLoadMoreUniversities;
  final Function(University) onTap;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: GridView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: widget.universities.map((university) {
          return InkWell(
            onTap: () => widget.onTap(university),
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
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (scrollController.position.extentAfter == 0) {
        widget.onLoadMoreUniversities.call();
      }
    }
    return false;
  }
}
