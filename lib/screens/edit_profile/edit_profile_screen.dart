import 'dart:io';

import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: AppColors.priceColor, fontSize: 25),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.priceColor),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 15.w,
            right: 15.w,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 140.w,
                    height: 140.h,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _imageFile != null
                            ? Image(
                                image: FileImage(File(_imageFile!.path)),
                                fit: BoxFit.cover,
                              )
                            : const Image(
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                              )),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.priceColor),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Satyam Gupta',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Satyam@gmail.com',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Satyam Gupta',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: AppColors.priceColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.priceColor,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: AppColors.cardColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          const Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
              ),
              IconButton(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.image_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}
