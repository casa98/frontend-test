import 'package:flutter/material.dart';

import '../../../models/university.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({
    Key? key,
    required this.universities,
    required this.onLoadMoreUniversities,
    required this.onTap,
  }) : super(key: key);

  final List<University> universities;
  final VoidCallback onLoadMoreUniversities;
  final Function(University) onTap;

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
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
      child: ListView.separated(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final university = widget.universities[index];
          return ListTile(
            title: Text(university.name),
            onTap: () => widget.onTap(university),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 0.0, thickness: 0.7);
        },
        itemCount: widget.universities.length,
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
