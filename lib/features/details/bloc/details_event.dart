part of 'details_bloc.dart';

class DetailsEvent extends Equatable {
  const DetailsEvent({required this.photoPath});

  final String photoPath;

  @override
  List<Object> get props => [photoPath];
}
