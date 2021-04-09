import 'package:book_reselling_app/Screens/HomePage.dart';
import 'package:book_reselling_app/services/storage.dart';
import 'package:book_reselling_app/widgets/common.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _enrolementNoController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _collegeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBG,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 50,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Profile",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration:
                            textBoxDecoration("Name", Icons.account_circle),
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Name is required";
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration:
                            textBoxDecoration("Enrolement No", Icons.person),
                        controller: _enrolementNoController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enrolement Number is required";
                          }
                          if (val.length != 12) {
                            return "Enrolement Number is invalid";
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: textBoxDecoration("Phone No", Icons.phone),
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Phone Number is required";
                          }
                          if (val.length != 10) {
                            return "Phone Number is invalid";
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration:
                            textBoxDecoration("Collage Name", Icons.school),
                        controller: _collegeController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Phone Number is required";
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onTap: () async {
                            //todo:
                            if (formKey.currentState.validate()) {
                              StorageMethods().addProfileDetails(
                                _nameController.text,
                                _enrolementNoController.text,
                                _phoneController.text,
                                _collegeController.text,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
