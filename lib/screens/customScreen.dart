// import 'dart:io';
// import 'dart:async';
// import 'package:Angrybaaz/screens/homeOverviewScreen.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CustomScreen extends StatefulWidget {
//   static const id = 'CustomScreen';
//   @override
//   _CustomScreenState createState() => _CustomScreenState();
// }

// class _CustomScreenState extends State<CustomScreen> {
//   String _designLink;
//   PickedFile _image;
//   PickedFile _myDesign;
//   String title = 'text';
//   String _linkGot;
//   bool _hideEditTools = false;
//   bool _successMessageToggler = false;
//   FirebaseFirestore _dataStore = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//   final ImagePicker _dPicker = ImagePicker();

//   Future getImage() async {
//     PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         print('image inide _image');
//         _image = PickedFile(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future uploadDesign() async {
//     PickedFile pickedDesign =
//         await _dPicker.getImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedDesign != null) {
//         print('image inide _image');
//         _myDesign = PickedFile(pickedDesign.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future uploadImageToFirebaseStorage(
//     BuildContext ctx,
//   ) async {
//     List pathList = _image.path.split('/');
//     int len = pathList.length;
//     String fileName = pathList.elementAt(len - 1).toString();
//     print(fileName);
//     StorageReference firebaseStorageRef = FirebaseStorage.instance
//         .ref()
//         .child('uploadedForCustomization/$fileName');
//     StorageUploadTask uploadTask =
//         firebaseStorageRef.putFile(File(_image.path));
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     taskSnapshot.ref.getDownloadURL().then(
//       (value) {
//         _linkGot = value;
//         print("Done:$value");
//         setState(() {
//           _successMessageToggler = true;
//         });
//       },
//     );
//   }

//   Future uploadDesignToFirebaseStorage(
//     BuildContext ctx,
//   ) async {
//     List _pathList = _myDesign.path.split('/');
//     int len = _pathList.length;
//     String fileName = _pathList.elementAt(len - 1).toString();
//     print(fileName);
//     StorageReference _firebaseStorageRef = FirebaseStorage.instance
//         .ref()
//         .child('designUploadedForCustomization/$fileName');
//     StorageUploadTask uploadTask =
//         _firebaseStorageRef.putFile(File(_myDesign.path));
//     StorageTaskSnapshot _taskSnapshot = await uploadTask.onComplete;
//     _taskSnapshot.ref.getDownloadURL().then(
//       (value) {
//         _designLink = value;
//         print("Done:$value");
//         setState(() {
//           _successMessageToggler = true;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size _deviceSize = MediaQuery.of(context).size;
//     double height = _deviceSize.height;
//     double width = _deviceSize.width;

//   }
// }
