import 'package:book_reselling_app/services/storage.dart';
import 'package:book_reselling_app/widgets/BookCard.dart';
import 'package:book_reselling_app/widgets/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyUploadedBooks extends StatefulWidget {
  @override
  _MyUploadedBooksState createState() => _MyUploadedBooksState();
}

class _MyUploadedBooksState extends State<MyUploadedBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Uploaded Books"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: StorageMethods().myUploadedBooks(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return BookTileCard(
                  title: ds.get("title"),
                  sem: ds.get("sem"),
                  branch: ds.get("branch"),
                  img: ds.get("imageURL"),
                  description: ds.get("description"),
                );
              },
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
