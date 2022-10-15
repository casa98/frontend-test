part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class OnLoadedState extends HomeState {
  const OnLoadedState({
    required this.displayAsListView,
    required this.errorMessage,
    required this.universities,
  });

  final bool displayAsListView;
  final String? errorMessage;
  final List<University> universities;

  @override
  List<Object> get props => [displayAsListView, universities];
}

class OnLoadingState extends HomeState {
  const OnLoadingState({required this.loading});

  final bool loading;

  @override
  List<Object> get props => [loading];
}
