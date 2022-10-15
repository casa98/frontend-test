import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final university = state.universities[index];
                  return ListTile(
                    title: Text(university.name),
                    onTap: () => onTap(university),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 0.0, thickness: 0.7);
                },
                itemCount: state.universities.length,
              );
            }
            return GridView(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: state.universities.map((university) {
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
