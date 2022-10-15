part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnLoadedEvent extends HomeEvent {
  const OnLoadedEvent({
    required this.errorMessage,
    required this.universities,
  });

  final String? errorMessage;
  final List<University> universities;
}

class OnLoadingEvent extends HomeEvent {
  const OnLoadingEvent({required this.loading});

  final bool loading;
}
