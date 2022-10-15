part of 'details_bloc.dart';

class DetailsState extends Equatable {
  const DetailsState({required this.photoPath});

  final String photoPath;

  @override
  List<Object> get props => [photoPath];
}
