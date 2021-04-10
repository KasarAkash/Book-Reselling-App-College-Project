import 'dart:io';

import 'package:book_reselling_app/Screens/HomePage.dart';
import 'package:book_reselling_app/Screens/addImages.dart';
import 'package:book_reselling_app/services/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

// ignore: must_be_immutable
class UploadBook extends StatefulWidget {
  List<File> images;

  UploadBook({Key key, this.images}) : super(key: key);
  @override
  _UploadBookState createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook> {
  final _formKey = GlobalKey<FormState>();

  String semValue = "Select Semester";
  var semItems = ["Select Semester", '1', '2', '3', '4', '5', '6'];

  String branchValue = "Select Branch";
  var branchItems = [
    "Select Branch",
    "Computer",
    "Civil",
    "Chemical",
    "Electrical",
    "Mechanical"
  ];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Reference ref;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Book"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: widget.images.isEmpty
                              ? () {
                                  //todo:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AddImages(),
                                    ),
                                  );
                                }
                              : () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: widget.images.isEmpty
                                  ? Colors.redAccent
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.images.isEmpty
                                  ? "Add Images"
                                  : "Image is Available",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "This field is Required";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Title (Ex. Name of Book)",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: Colors.deepPurple.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: semValue,
                          validator: (val) {
                            if (semValue == "Select Semester") {
                              return "Select Semester";
                            }
                          },
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          icon: SizedBox(),
                          items: semItems.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              semValue = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: branchValue,
                          validator: (val) {
                            if (branchValue == "Select Branch") {
                              return "Select Branch";
                            }
                          },
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          icon: SizedBox(),
                          items: branchItems.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              branchValue = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "This field is Required";
                          }
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintMaxLines: 5,
                          hintText: "Description",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: Colors.deepPurple.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      //todo:
                      if (_formKey.currentState.validate()) {
                        if (widget.images.isEmpty) {
                          _showDialog();
                        } else {
                          uploadFiles();
                          _showSnackbar();
                          Future.delayed(Duration(milliseconds: 1000), () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(),
                              ),
                              (route) => false,
                            );
                          });
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Upload Book Details",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadFiles() async {
    List imgList = [];
    for (var img in widget.images) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images/${Path.basename(img.path)}");
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgList.add(value);
        });
      });
    }
    listImg(imgList);
  }

  listImg(imgList) {
    StorageMethods().uploadBookDetails(
      _titleController.text,
      semValue,
      branchValue,
      _descriptionController.text,
      imgList,
    );
  }

  _showSnackbar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Book is Uploaded"),
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Images'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Images are empty select Images'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
