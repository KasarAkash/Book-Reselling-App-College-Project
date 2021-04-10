import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class StorageMethods {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User user = FirebaseAuth.instance.currentUser;

  String timeNow = DateFormat("hh:mm:ss dd-MM-yyyy").format(DateTime.now());

  static userID() {
    return user.email.replaceAll("@gmail.com", "");
  }

// TODO: time stamp
  getBooksList() {
    try {
      return firestore.collection("Books").orderBy("timeStamp").snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  static deleteTheBook(var docID) {
    return firestore.collection("Books").doc(docID).delete();
  }

  myUploadedBooks() {
    try {
      return firestore
          .collection("Books")
          .where("uploadBy", isEqualTo: userID())
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  filteredBooksList(String sem, String branch) {
    try {
      return firestore
          .collection("Books")
          .where("sem", isEqualTo: sem)
          .where("branch", isEqualTo: branch)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  uploadBookDetails(
      String title, String sem, String branch, String description, img) {
    try {
      return firestore.collection("Books").add({
        "title": title,
        "sem": sem,
        "branch": branch,
        "description": description,
        "imageURL": img,
        "uploadBy": userID(),
        "timeStamp": timeNow,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addProfileDetails(
    String name,
    String enroll,
    String phone,
    String college,
  ) {
    try {
      return firestore.collection("User").doc(userID()).set({
        "name": name,
        "enrollment_no": enroll,
        "phone_no": phone,
        "college": college,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getProfileDetails() {
    try {
      return firestore.collection("User").doc(userID()).get();
    } catch (e) {
      print(e.toString());
    }
  }
}
