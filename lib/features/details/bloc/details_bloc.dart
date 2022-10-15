import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(const DetailsState(photoPath: '')) {
    on<DetailsEvent>((event, emit) {
      emit(DetailsState(photoPath: event.photoPath));
    });
  }

  void getPhotoPath(ImageSource source) async {
    if (source == ImageSource.gallery) {
      await Permission.photos.request();
      final permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted) {
        final picker = ImagePicker();
        final photo = await picker.pickImage(source: ImageSource.gallery);
        add(DetailsEvent(photoPath: photo?.path ?? ''));
      }
    } else {
      await Permission.camera.request();
      final permissionStatus = await Permission.camera.status;
      if (permissionStatus.isGranted) {
        final picker = ImagePicker();
        final photo = await picker.pickImage(source: ImageSource.camera);
        add(DetailsEvent(photoPath: photo?.path ?? ''));
      }
    }
  }

  void clearPath() {
    add(const DetailsEvent(photoPath: ''));
  }
}
