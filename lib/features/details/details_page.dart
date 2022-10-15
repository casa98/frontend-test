import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../models/university.dart';
import 'bloc/details_bloc.dart';
import 'widgets/choose_image_source.dart';
import 'widgets/subtitle_widget.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.university,
  }) : super(key: key);

  final University university;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  static const paddingValue = 12.0;

  late final TextEditingController controller;
  late DetailsBloc _detailsBloc;

  bool photoLoaded = false;
  String? photoPath;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _detailsBloc = context.read<DetailsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Details'),
      ),
      body: GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: paddingValue),
              Text(
                widget.university.name,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: paddingValue * 2),
              const SubtitleWidget('Location'),
              const SizedBox(height: paddingValue),
              Text(
                '${widget.university.stateProvince == null ? '' : widget.university.stateProvince + ', '}${widget.university.country} (${widget.university.alphaTwoCode})',
              ),
              const SizedBox(height: paddingValue * 2),
              const SubtitleWidget('Webpages'),
              const SizedBox(height: paddingValue),
              for (var i in widget.university.webPages)
                GestureDetector(
                  onTap: () async {
                    try {
                      await url_launcher.launchUrl(Uri.parse(i));
                    } catch (err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong launching URL'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    i,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              const SizedBox(height: paddingValue * 2),
              const SubtitleWidget('Domains'),
              const SizedBox(height: paddingValue),
              for (var i in widget.university.domains) Text(i),
              const SizedBox(height: paddingValue * 2),
              const SubtitleWidget('Number of Students'),
              const SizedBox(height: paddingValue),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter number of students',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: paddingValue * 2),
              const SubtitleWidget('Photo'),
              const SizedBox(height: paddingValue),
              BlocBuilder<DetailsBloc, DetailsState>(
                builder: (context, state) {
                  if (state.photoPath.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      child: Image.file(File(state.photoPath)),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No photo uploaded, yet.',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: paddingValue / 2),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final source =
                              await showModalBottomSheet<ImageSource>(
                            context: context,
                            builder: (_) => const ChooseImageSource(),
                          );
                          if (source is ImageSource) {
                            _detailsBloc.getPhotoPath(source);
                          }
                        },
                        child: const Text('Upload'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _detailsBloc.clearPath();
    super.dispose();
  }
}
