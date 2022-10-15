import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend_test/features/home/widgets/grid_view_widget.dart';
import 'package:fontend_test/features/home/widgets/list_view_widget.dart';

import '../../models/university.dart';
import '../details/details_page.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universities'),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is OnLoadingState) {
                return const SizedBox.shrink();
              }
              return IconButton(
                splashRadius: 22.0,
                onPressed: _homeBloc.switchViewMode,
                icon: _homeBloc.displayAsListView
                    ? const Icon(Icons.grid_on_outlined)
                    : Transform.rotate(
                        angle: math.pi / 2,
                        child: const Icon(Icons.view_column_outlined),
                      ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is OnLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24.0),
                  Text(
                    'Loading universities',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            );
          }
          if (state is OnLoadedState) {
            if (state.displayAsListView) {
              return ListViewWidget(
                universities: state.universities,
                onTap: onTap,
              );
            }
            return GridViewWidget(
              universities: state.universities,
              onTap: onTap,
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Estado desconocido: ${state.runtimeType}'),
            ),
          );
        },
      ),
    );
  }

  void onTap(University university) {
// Basic navigation just for two screens
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return DetailsPage(university: university);
      }),
    );
  }
}
