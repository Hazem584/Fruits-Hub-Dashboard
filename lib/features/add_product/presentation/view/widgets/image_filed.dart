import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageFiled extends StatefulWidget {
  const ImageFiled({super.key, this.onFileChanged});
  final ValueChanged<File?>? onFileChanged;

  @override
  State<ImageFiled> createState() => _ImageFiledState();
}

class _ImageFiledState extends State<ImageFiled> {
  bool isLoading = false;
  File? imagePath;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            await PIckImage();
          } catch (e) {
            // TODO
          }
          isLoading = false;
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imagePath != null
                    ? Image.file(imagePath!)
                    : Icon(Icons.image_outlined, size: 200),
              ),
            ),
            Visibility(
              visible: imagePath != null,
              child: IconButton(
                onPressed: () {
                  imagePath = null;
                  widget.onFileChanged?.call(imagePath);
                  setState(() {});
                },
                icon: Icon(Icons.remove_circle, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> PIckImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imagePath = File(image!.path);
    widget.onFileChanged?.call(imagePath);
    setState(() {});
  }
}
