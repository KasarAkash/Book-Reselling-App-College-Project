import 'package:book_reselling_app/Screens/MyUploadedBooks.dart';
import 'package:book_reselling_app/services/storage.dart';
import 'package:book_reselling_app/widgets/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder(
        future: StorageMethods().getProfileDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          User user = FirebaseAuth.instance.currentUser;
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return ListView(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.black, width: 3),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                user.photoURL.toString(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${StorageMethods.user.email}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Name"),
                  subtitle: Text(data["name"]),
                ),
                ListTile(
                  title: Text("Enrollmrnt No"),
                  subtitle: Text(data["enrollment_no"]),
                ),
                ListTile(
                  title: Text("Phone"),
                  subtitle: Text(data["phone_no"]),
                ),
                ListTile(
                  title: Text("College"),
                  subtitle: Text(data["college"]),
                ),
                Divider(thickness: 3),
                ListTile(
                  title: Text("My Uploaded Books"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyUploadedBooks(),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return Loading();
        },
      ),
    );
  }
}
