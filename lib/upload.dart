import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zee_tree/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:zee_tree/constants.dart';
import 'package:geolocator/geolocator.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

//import 'package:path/path.dart';

final Color green = Colors.lightGreenAccent;
final Color lightgreen = Colors.green.shade900;

class UploadingImage extends StatefulWidget {
  @override
  _UploadingImageState createState() => _UploadingImageState();
}

class _UploadingImageState extends State<UploadingImage> {
  var currentposition = "";

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('permission not given');
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      print(currentPosition);
      currentposition = currentPosition.toString();
    }
  }

  final fb = FirebaseDatabase.instance;
  File _imageFile;

  final picker = ImagePicker();
  var imageUrl = "";

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    imageUrl = await taskSnapshot.ref.getDownloadURL();
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("$value"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   elevation: 0,
      //   backgroundColor: Colors.green.shade900,
      // ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [lightgreen, green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
              margin: const EdgeInsets.only(top: 45, right: 40),
              height: 40,
              width: 180,
              child: TextButton.icon(
                icon: Icon(Icons.arrow_back_ios_outlined),
                label: Text('Back TO Home Page'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              )),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 290),
            height: 30,
            width: 180,
            child: IconButton(
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                getCurrentPosition();
                uploadImageToFirebase(context);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 90),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading The Image Of Your Plant",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile)
                              : FlatButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                  onPressed: pickImage,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    final ref = fb.reference().child("Users").push();
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [green, lightgreen],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () {
                ref.child('name').set(Constants.username);
                ref.child('image').set(imageUrl);
                ref.child('location').set(currentposition);
              },
              // => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
