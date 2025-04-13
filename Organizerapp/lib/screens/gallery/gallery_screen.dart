import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late EventProvider eventProvider;

  List<String> toBeUploadedImagesString = [];
  List<String> toBeDeletedImagesNames = [];

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    toBeDeletedImagesNames.clear();
    toBeUploadedImagesString.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          getTranslated(context, 'gallery')!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: AppFontFamily.poppinsMedium
          ),
        ),
      ),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            ///gallery
            Wrap(
              spacing: 15,
              runSpacing: 10,
              children: List.generate(
                toBeUploadedImagesString.length + 1,
                (index) {
                  return index == 0
                      ? InkWell(
                          onTap: () {
                            chooseEventImage(context);
                          },
                          child: Container(
                            width: 80,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: blackColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.add, color: blackColor),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.expand,
                            children: [
                              Image.memory(
                                base64Decode(toBeUploadedImagesString[index - 1]),
                                fit: BoxFit.cover,
                              ),
                              //Delete Icon Button
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      toBeUploadedImagesString.removeAt(index - 1);
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.close, color: whiteColor, size: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
            const SizedBox(height: 10),
            if (eventProvider.gallery.isNotEmpty)
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: List.generate(
                  eventProvider.gallery.length,
                  (index) {
                    return Container(
                      width: 80,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: "${eventProvider.imagePath}${eventProvider.gallery[index]}",
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                                strokeWidth: 3,
                                color: primaryColor.withOpacity(0.4),
                              ),
                            ),
                          ),
                          //Delete Icon Button
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showDeleteImageDialog(context, eventProvider.gallery[index], index);
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.close, color: whiteColor, size: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // select Event image

  File? pickedImage;
  final picker = ImagePicker();
  String pickedImageString = "";

  chooseEventImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    getTranslated(context, 'gallery').toString(),
                  ),
                  onTap: () {
                    _eventImgFromGallery(context);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  getTranslated(context, 'camera').toString(),
                ),
                onTap: () {
                  _eventImgFromCamera(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _eventImgFromGallery(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      List<int> imageBytes = pickedImage!.readAsBytesSync();
      pickedImageString = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        "id": eventProvider.eventId,
        "image": pickedImageString,
      };
      try {
        eventProvider.eventImageAdd(body).then((value) {
          value.data!.success == true ? eventProvider.gallery.add(value.data!.data!) : null;
          eventProvider.refresh();
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  void _eventImgFromCamera(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      List<int> imageBytes = pickedImage!.readAsBytesSync();
      pickedImageString = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        "id": eventProvider.eventId,
        "image": pickedImageString,
      };
      try {
        eventProvider.eventImageAdd(body).then((value) {
          value.data!.success == true ? eventProvider.gallery.add(value.data!.data!) : null;
          eventProvider.refresh();
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  showDeleteImageDialog(BuildContext context, String imageName, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete", textAlign: TextAlign.center),
        content: const Text("Are you sure to delete this image."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text(
              "Cancel",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Map<String, dynamic> body = {
                "id": eventProvider.eventId,
                "image": eventProvider.gallery[index],
              };
              try {
                eventProvider.eventImageRemove(body).then((value) {
                  if (value.data != null) {
                    value.data!.success == true ? eventProvider.gallery.removeAt(index) : null;
                  eventProvider.refresh();
                  }
                });
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              "Delete",
            ),
          ),
        ],
      ),
    );
  }
}
