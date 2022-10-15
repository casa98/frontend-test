import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ChooseImageSource extends StatelessWidget {
  const ChooseImageSource({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Let's get Android UI only, time limitations
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            Icons.camera_alt,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text('Camera'),
          onTap: () {
            Navigator.of(context).pop(ImageSource.camera);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.photo,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text('Gallery'),
          onTap: () {
            Navigator.of(context).pop(ImageSource.gallery);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.cancel,
            color: Theme.of(context).primaryColor,
          ),
          title: const Text('Cancel'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
