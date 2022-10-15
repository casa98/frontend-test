import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fontend_test/services/api_service.dart';

import '../../../models/university.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const OnLoadingState(loading: true)) {
    on<OnLoadedEvent>((event, emit) {
      emit(OnLoadedState(
        errorMessage: event.errorMessage,
        universities: event.universities,
      ));
    });

    on<OnLoadingEvent>((event, emit) {
      emit(OnLoadingState(loading: event.loading));
    });
  }

  void getUniversities() async {
    final response = await ApiService.getUniversities();
    log('response length: ${response.length.toString()}');
    final universities =
        response.map((university) => University.fromJson(university)).toList();

    add(OnLoadedEvent(universities: universities));
  }
}
