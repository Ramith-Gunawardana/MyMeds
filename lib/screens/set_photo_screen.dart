import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../components/common_buttons.dart';
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
  File? _image;

  Future <void>_pickImage(ImageSource source) async{
    try{
    final image = await ImagePicker().pickImage(source: source);
    if (image == null)return;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      _image =img;
      Navigator.of(context).pop();
    });
  } on PlatformException catch (e){
    print(e);
    Navigator.of(context).pop();
  }
  }

  Future<File?> _cropImage({required File imageFile}) async{
    CroppedFile? croppedImage = 
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if(croppedImage == null)return null;
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
              child:  SelectPhotoOptionsScreen(
                onTap: _pickImage,),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 0, 0, 0),
        title: const Text('Set photo of prescription',
        style: TextStyle(fontSize: 23,color: Colors.white),),
        leading: IconButton(onPressed: (){},
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 255, 255, 255),
        ),),),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(
                left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             const Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
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
                          width : MediaQuery.of(context).size.width * 1.5, 
                          height : MediaQuery.of(context).size.width * 1.1, 
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade200,
                          ),
                          child:  Center(
                            child: _image == null
                            ? const Text(
                              'No image selected',
                              style: TextStyle(fontSize: 20),
                            )
                            : Image.file(
                                _image!,
                                width : MediaQuery.of(context).size.width * 1.5, 
                                height : MediaQuery.of(context).size.width * 1.1,
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
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
