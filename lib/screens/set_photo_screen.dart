import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mymeds_app/screens/settings.dart';
import '../components/common_buttons.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/constants.dart';
import 'select_photo_options_screen.dart';

// ignore: must_be_immutable
class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser;
  //************IMAGE PATH***********
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('${FirebaseAuth.instance.currentUser!.email}/Prescription');

  String? url;

  Future<String> getPhotoUrl() async {
    url = await storageRef.getDownloadURL();
    print(url);
    return url!;
  }

  //image
  File? _image;
  String? _selectedImageUrl;

  String _saveBtnText = 'Save';
  IconData _saveBtnIcon = Icons.save;

  @override
  void initState() {
    super.initState();
    getPhotoUrl();
    if (_selectedImageUrl != null) {
      setState(() {
        _image = null;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);

      //   if (img != null) {
      //   final storageRef = FirebaseStorage.instance
      //     .ref()
      //     .child('prescription_photos/${DateTime.now().millisecondsSinceEpoch}.png');

      // await storageRef.putFile(img);

      // final imageUrl = await storageRef.getDownloadURL();

      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
      //}
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveImageToFirebase() async {
    if (_image != null) {
      //loading circle
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(7, 82, 96, 1),
            ),
          );
        },
      );

      await storageRef.putFile(_image!);
      if (!mounted) {
        return;
      }
      //pop loading cicle
      Navigator.of(context).pop();

      final _imageUrl = await storageRef.getDownloadURL();
      print('Image url: $_imageUrl');
      setState(() {
        _saveBtnText = 'Saved';
        _saveBtnIcon = Icons.library_add_check;
        _image=null;
        _selectedImageUrl=null;
        getPhotoUrl();
      });
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Set photo of prescription',
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const AppSettings(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
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
                        height: MediaQuery.of(context).size.width * 1.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: _image == null
                              ? (_selectedImageUrl == null
                                  ? FutureBuilder(
                                      future: getPhotoUrl(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          print(snapshot);
                                          if (snapshot.hasData) {
                                            return Image.network(url!);
                                          } else {
                                            return Text('No image');
                                          }
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return Text('Error');
                                        }
                                      },
                                    )
                                  : const Text(
                                      'No image selected',
                                      style: TextStyle(fontSize: 20),
                                    ))
                              : Image.file(
                                  _image!,
                                  width:
                                      MediaQuery.of(context).size.width * 1.5,
                                  height:
                                      MediaQuery.of(context).size.width * 1.0,
                                  fit: BoxFit.fill,
                                ),

                          // Center(
                          //   child: _image == null
                          //       ? (url != null
                          //           ? Image.network(url!)
                          //           : const Text(
                          //               'No image selected',
                          //               style: TextStyle(fontSize: 20),
                          //             ))
                          //       : Image.file(
                          //           _image!,
                          //           width:
                          //               MediaQuery.of(context).size.width * 1.5,
                          //           height:
                          //               MediaQuery.of(context).size.width * 1.0,
                          //           fit: BoxFit.fill,
                          //         ),

                          //   // :CircleAvatar(
                          //   //   radius: 100.0,
                          //   //   backgroundImage: FileImage(_image!),
                          //   //   fit:BoxFit.fill,
                          //   //   )
                          // ),
                        ),
                        // child: Image.network(url!),
                      ),
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
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _saveImageToFirebase,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_saveBtnText),
                      SizedBox(width: 8),
                      Icon(_saveBtnIcon),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
