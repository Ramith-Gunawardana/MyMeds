import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymeds_app/screens/select_photo_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/constants.dart';

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

  String _saveBtnText = 'Upload';
  IconData _saveBtnIcon = Icons.upload_file_outlined;

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
    print(_image);
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

      final imageUrl = await storageRef.getDownloadURL();
      print('Image url: $imageUrl');
      setState(() {
        _saveBtnText = 'Done uploading';
        _saveBtnIcon = Icons.done_outline_rounded;
        _image = null;
        _selectedImageUrl = null;
        getPhotoUrl();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 7, 83, 96),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Prescription image uploaded successfully',
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _saveBtnText = 'Upload';
            _saveBtnIcon = Icons.upload_file_outlined;
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 7, 83, 96),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Please select an prescription image first',
          ),
        ),
      );
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
          'Save a photo of your prescription',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 5.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Upload a clear photo of your prescription',
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
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
                                            // return Image.network(url!);
                                            return Image.network(
                                              url!,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return const Text('No image');
                                          }
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return const Text('Error');
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
                  // CommonButtons(
                  //   onTap: () => _showSelectPhotoOptions(context),
                  //   backgroundColor: Colors.black,
                  //   textColor: Colors.white,
                  //   textLabel: 'Add a Photo',
                  // ),

                  //add a photo button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      onPressed: () => _showSelectPhotoOptions(context),
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(2),
                        // backgroundColor: MaterialStatePropertyAll(
                        //   Color.fromARGB(255, 7, 82, 96),
                        // ),
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
                ],
              ),
              //save button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _saveImageToFirebase();
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
                  label: Text(
                    _saveBtnText,
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Icon(_saveBtnIcon),
                ),
              ),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: _saveImageToFirebase,
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Text(_saveBtnText),
              //         const SizedBox(width: 8),
              //         Icon(_saveBtnIcon),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
