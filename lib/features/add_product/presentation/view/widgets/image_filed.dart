import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFiled extends StatelessWidget {
  const ImageFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.image_outlined, size: 200),
      ),
    );
  }
}
