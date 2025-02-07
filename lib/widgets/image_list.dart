import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageList extends StatelessWidget {
  final List<XFile>? imageFiles;

  const ImageList({super.key, required this.imageFiles});

  @override
  Widget build(BuildContext context) {
    if (imageFiles == null || imageFiles!.isEmpty) {
      return const Center(child: Text("No images selected."));
    }
    return ListView.builder(
      itemCount: imageFiles!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(
            File(imageFiles![index].path),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
