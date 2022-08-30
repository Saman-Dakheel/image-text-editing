import 'dart:typed_data';

import 'package:edit_image_with_text/model/text_model.dart';
import 'package:edit_image_with_text/screens/editImageScreen.dart';
import 'package:edit_image_with_text/utils/utils.dart';
import 'package:edit_image_with_text/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  List<TextInfo> texts = [];

  int currentIndex = 0;

  saveToGallery(BuildContext context) {
    screenshotController.capture().then((Uint8List? image) {
      saveImage(image!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Image Save To Gallery.",
          ),
        ),
      );
    }).catchError((err) => print(err));
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Deleted",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  setCurrentIndex(BuildContext context, int index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Selected for Styling",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignleft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  aligncenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignright() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldtext() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italictext() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  addNewText(BuildContext context) {
    texts.add(
      TextInfo(
        text: textEditingController.text,
        left: 0,
        top: 0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 20,
        fontStyle: FontStyle.normal,
        textAlign: TextAlign.center,
      ),
    );
    Navigator.of(context).pop();
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Text',
          ),
          content: TextField(
            controller: textEditingController,
            maxLines: 5,
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.edit,
              ),
              filled: true,
              hintText: 'Add New Text',
            ),
          ),
          actions: <Widget>[
            DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
              color: Colors.white,
              textColor: Colors.black,
            ),
            DefaultButton(
              onPressed: () => addNewText(context),
              child: const Text("Add Text "),
              color: Colors.red,
              textColor: Colors.black,
            ),
          ],
        );
      },
    );
  }
}
