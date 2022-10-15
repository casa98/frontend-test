import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/university.dart';
import '../../../services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const OnLoadingState(loading: true)) {
    on<OnLoadedEvent>((event, emit) {
      emit(OnLoadedState(
        length: currentShowingUniversities.length,
        displayAsListView: displayAsListView,
        errorMessage: event.errorMessage,
        universities: event.universities,
      ));
    });

    on<OnLoadingEvent>((event, emit) {
      emit(OnLoadingState(loading: event.loading));
    });
  }

  var currentPage = 0;
  var displayAsListView = true;
  var pageSize = 20;

  final allUniversities = <University>[];
  final currentShowingUniversities = <University>[];

  void getUniversities() async {
    final response = await ApiService.getUniversities();
    allUniversities
      ..clear()
      ..addAll(response
          .map((university) => University.fromJson(university))
          .toList());
    loadMoreUniversities();
  }

  void switchViewMode() {
    displayAsListView = !displayAsListView;
    add(OnLoadedEvent(
      length: currentShowingUniversities.length,
      displayAsListView: displayAsListView,
      universities: currentShowingUniversities,
    ));
  }

  void loadMoreUniversities() {
    log('bloc to get more items: Current length: ${currentShowingUniversities.length}');
    for (var i = 0; i < 20; i++) {
      currentShowingUniversities.add(
        allUniversities[currentPage * pageSize + i],
      );
    }

    add(OnLoadedEvent(
      length: currentShowingUniversities.length,
      displayAsListView: displayAsListView,
      universities: currentShowingUniversities,
    ));
    currentPage++;
  }
}
