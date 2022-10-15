import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is OnLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 24.0),
                  Text('Loading universities'),
                ],
              ),
            );
          }
          if (state is OnLoadedState) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final university = state.universities[index];
                return ListTile(
                  title: Text(university.name),
                  onTap: () {
                    // Basic navigation just for two screens
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return DetailsPage(university: university);
                      }),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0.0, thickness: 0.7);
              },
              itemCount: state.universities.length,
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
}
