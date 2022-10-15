import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend_test/features/home/bloc/home_bloc.dart';

import '../../../models/university.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({
    Key? key,
    required this.universities,
    required this.onTap,
    required this.onLoadMoreUniversities,
  }) : super(key: key);

  final List<University> universities;
  final Function(University) onTap;
  final VoidCallback onLoadMoreUniversities;

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final university = widget.universities[index];
        return ListTile(
          title: Text(university.name),
          onTap: () => widget.onTap(university),
          onLongPress: () {
            log('currently show ${context.read<HomeBloc>().currentShowingUniversities.length} items');
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 0.0, thickness: 0.7);
      },
      itemCount: widget.universities.length,
    );
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 100) {
      widget.onLoadMoreUniversities.call();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
