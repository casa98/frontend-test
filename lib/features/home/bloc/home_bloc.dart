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
        displayAsListView: displayAsListView,
        errorMessage: event.errorMessage,
        universities: event.universities,
      ));
    });

    on<OnLoadingEvent>((event, emit) {
      emit(OnLoadingState(loading: event.loading));
    });
  }

  var displayAsListView = false;
  var universities = <University>[];

  void getUniversities() async {
    final response = await ApiService.getUniversities();
    universities
      ..clear()
      ..addAll(response
          .map((university) => University.fromJson(university))
          .toList());

    add(OnLoadedEvent(
      displayAsListView: displayAsListView,
      universities: universities,
    ));
  }

  void switchViewMode() {
    displayAsListView = !displayAsListView;
    add(OnLoadedEvent(
      displayAsListView: displayAsListView,
      universities: universities,
    ));
  }
}
