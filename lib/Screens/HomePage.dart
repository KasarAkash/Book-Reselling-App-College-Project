import 'package:book_reselling_app/Screens/Signin.dart';
import 'package:book_reselling_app/services/auth.dart';
import 'package:book_reselling_app/services/storage.dart';
import 'package:book_reselling_app/widgets/BookCard.dart';
import 'package:book_reselling_app/widgets/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ProfileScreen.dart';
import 'UploadBookPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFiltering = false;
  final formKey = GlobalKey<FormState>();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfileScreen(),
                  ),
                );
              }),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              setState(() {});
              await Authentication.signOut();
              setState(() {});
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => SignInPage(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueAccent[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    isFiltering
                        ? IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              setState(() {
                                isFiltering = false;
                              });
                            },
                          )
                        : SizedBox(),
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.filter_list_rounded),
                  onPressed: () {
                    filterSheet();
                  },
                ),
              ],
            ),
          ),
          isFiltering ? filteredBookList() : bookList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Upload Book",
        child: Icon(Icons.add),
        onPressed: () {
          //todo:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => UploadBook(images: []),
            ),
          );
        },
      ),
    );
  }

  Widget bookList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: StorageMethods().getBooksList(),
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
                  uploadBy: ds.get("uploadBy"),
                  cardID: ds.id,
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

  Widget filteredBookList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: StorageMethods().filteredBooksList(semValue, branchValue),
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
                  uploadBy: ds.get("uploadBy"),
                  cardID: ds.id,
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

  filterSheet() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Filter Books",
          ),
          actions: [
            InkWell(
              onTap: () {
                if (formKey.currentState.validate()) {
                  setState(() {
                    isFiltering = true;
                  });
                  Navigator.pop(context);
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Text(
                  "Filter the list",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
          content: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: DropdownButtonFormField<String>(
                    validator: (val) {
                      if (semValue == "Select Semester") {
                        return "Select Semester";
                      }
                    },
                    value: semValue,
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
                    validator: (val) {
                      if (branchValue == "Select Branch") {
                        return "Select Branch";
                      }
                    },
                    decoration: InputDecoration(border: InputBorder.none),
                    value: branchValue,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
