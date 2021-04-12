import 'package:book_reselling_app/Screens/ImageView.dart';
import 'package:book_reselling_app/services/storage.dart';
import 'package:book_reselling_app/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';

class BookTileCard extends StatefulWidget {
  final String title;
  final String sem;
  final String branch;
  final List<dynamic> img;
  final String description;
  final String uploadBy;
  final String cardID;

  const BookTileCard({
    Key key,
    this.title,
    this.description,
    this.img,
    this.sem,
    this.branch,
    this.uploadBy,
    this.cardID,
  }) : super(key: key);
  @override
  _BookTileCardState createState() => _BookTileCardState();
}

class _BookTileCardState extends State<BookTileCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 20,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ImageView(
                      imgs: widget.img,
                    ),
                  ),
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.img[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          showOptions();
                        },
                      ),
                    ],
                  ),
                  Text(
                    "Semester: ${widget.sem} Branch: ${widget.branch}\n",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showOptions() {
    final email = widget.uploadBy + "@gmail.com";

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: StorageMethods().getProfileDetails(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();

              var name = data["name"];
              var clg = data["college"];
              var enroll = data["enrollment_no"];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.uploadBy != StorageMethods.userID()
                      ? ListTile(
                          title: Text("Request For Book"),
                          onTap: () {
                            final Uri _emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: '$email',
                              queryParameters: {
                                'subject': "I want to buy your Book",
                                'body':
                                    'Hi, My name is $name.\nI am from $clg College.\nMy Enrollment Number is $enroll.\nAnd I want to buy your Book'
                              },
                            );
                            launch(_emailLaunchUri.toString());
                            Navigator.pop(context);
                          },
                        )
                      : SizedBox(),
                  widget.uploadBy == StorageMethods.userID()
                      ? ListTile(
                          title: Text("Delete The Book"),
                          onTap: () {
                            StorageMethods.deleteTheBook(widget.cardID);
                            Navigator.pop(context);
                          },
                        )
                      : SizedBox(),
                ],
              );
            }
            return Loading();
          },
        );
      },
    );
  }
}
