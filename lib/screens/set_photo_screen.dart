import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymeds_app/screens/select_photo_options.dart';
import 'package:mymeds_app/screens/more.dart';
import '../components/common_buttons.dart';

import '../components/constants.dart';

// ignore: must_be_immutable
class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set photo of prescription',
        ),
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const More(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Text(
                      //   'Set a photo of prescription',
                      //   style: kHeadTextStyle,
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Text(
                        'Upload clear photo of your prescription',
                        style: kHeadSubtitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 1.5,
                          height: MediaQuery.of(context).size.width * 1.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: _image == null
                                ? const Text(
                                    'No image selected',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Image.file(
                                    _image!,
                                    width:
                                        MediaQuery.of(context).size.width * 1.5,
                                    height:
                                        MediaQuery.of(context).size.width * 1.1,
                                    fit: BoxFit.fill,
                                  ),

                            // :CircleAvatar(
                            //   radius: 100.0,
                            //   backgroundImage: FileImage(_image!),
                            //   fit:BoxFit.fill,
                            //   )
                          )),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const Text(
                  //   'Prescription',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      onPressed: () {
                        _showSelectPhotoOptions(context);
                      },
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(2),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Add a Photo',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // CommonButtons(
                  //   onTap: () => _showSelectPhotoOptions(context),
                  //   backgroundColor: Colors.black,
                  //   textColor: Colors.white,
                  //   textLabel: 'Add a Photo',
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
