import 'package:edit_image_with_text/screens/editImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
        icon: const Icon(Icons.upload_file),
        onPressed: () async {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
          );
          if (image != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return EditImageScreen(
                    selectedImage: image.path,
                  );
                },
              ),
            );
          }
        },
      )),
    );
  }
}
