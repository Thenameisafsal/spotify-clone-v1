import 'dart:io';

import 'package:client/core/theme/color_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_text_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;

  @override
  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  void selectAudio() async {
    final pickedAudio = await pickImage();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Songs"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:
                                Image.file(selectedImage!, fit: BoxFit.cover)),
                      )
                    : DottedBorder(
                        color: Pallete.borderColor,
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        dashPattern: const [10, 6],
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Select the thumbnail",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              selectedAudio != null
                  ? AudioWave(path: selectedAudio!.path)
                  : CustomTextField(
                      hint: "Pick a Song",
                      controller: null,
                      readOnly: true,
                      onTap: selectAudio,
                    ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: 'Artist',
                controller: artistNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: 'Song Name',
                controller: songNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              ColorPicker(
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
                color: selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
