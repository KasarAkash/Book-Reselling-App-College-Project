import 'dart:io';

import 'package:book_reselling_app/Screens/UploadBookPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatefulWidget {
  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<File> _images = [];
  final imgPicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Images"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadBook(
                    images: _images,
                  ),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: _images.length + 1,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return index == 0
              ? Container(
                  margin: EdgeInsets.all(3),
                  color: Colors.grey[300],
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      //todo:
                      chooseImages();
                    },
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_images[index - 1]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
        },
      ),
    );
  }

  chooseImages() async {
    final pickFile = await imgPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(pickFile.path));
    });
  }
}
