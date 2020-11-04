// import 'dart:io';
// import 'dart:async';
// import 'package:angrybaaz_user/screens/homeOverviewScreen.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:vector_math/vector_math_64.dart' show Vector3;
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
//   double _scale = 1.0;
//   double _previousScale = 1.0;

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

//   double top;
//   double left;
//   double finalAngle = 0.0;
//   double oldAngle = 0.0;
//   double upsetAngle = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     Size _deviceSize = MediaQuery.of(context).size;
//     double height = _deviceSize.height;
//     double width = _deviceSize.width;
//     return Form(
//       child: Stack(
//         children: [
//           if (_image == null)
//             GestureDetector(
//               onTap: () async {
//                 await getImage();
//                 print('yes');
//                 // await uploadImageToFirebaseStorage(context);
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: height,
//                 color: Colors.black,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Lottie.network(
//                       'https://assets2.lottiefiles.com/datafiles/VJiRdhfBobhR2ui/data.json',
//                     ),
//                     Text(
//                       'Upload Design',
//                       style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w900,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           if (_image != null)
//             Container(
//               color: Colors.red,
//               height: height,
//               child: Center(
//                 child: Image.file(
//                   File(_image.path),
//                 ),
//               ),
//             ),
//           if (_myDesign != null)
//             //added some code
//             Container(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   Offset centerOfGestureDetector = Offset(
//                       constraints.maxWidth / 2, constraints.maxHeight / 2);
//                   return GestureDetector(
//                     dragStartBehavior: DragStartBehavior.start,
//                     // behavior: HitTestBehavior.translucent,
//                     onVerticalDragUpdate: (DragUpdateDetails dd) {
//                       top = dd.localPosition.dy;
//                       left = dd.localPosition.dx;
//                       setState(() {});
//                     },
//                     onScaleStart: (ScaleStartDetails details) {
//                       final touchPositionFromCenter =
//                           details.localFocalPoint - centerOfGestureDetector;
//                       upsetAngle = oldAngle - touchPositionFromCenter.direction;
//                       _previousScale = _scale;
//                       setState(() {});
//                     },
//                     onScaleUpdate: (ScaleUpdateDetails details) {
//                       final touchPositionFromCenter =
//                           details.localFocalPoint - centerOfGestureDetector;
//                       _scale = _previousScale * details.scale;
//                       finalAngle =
//                           touchPositionFromCenter.direction + upsetAngle;
//                       setState(() {});
//                     },
//                     onScaleEnd: (ScaleEndDetails details) {
//                       _previousScale = 1.0;
//                       oldAngle = finalAngle;
//                       setState(() {});
//                     },
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: top,
//                           left: left,
//                           child: Transform.rotate(
//                             angle: finalAngle,
//                             child: Transform(
//                               alignment: FractionalOffset.center,
//                               transform: Matrix4.diagonal3(
//                                   Vector3(_scale, _scale, _scale)),
//                               child: Container(
//                                 width: 90.0,
//                                 height: height * 0.10,
//                                 child: Image.file(
//                                   File(_myDesign.path),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           if (_hideEditTools)
//             Positioned(
//               bottom: 55.0,
//               left: width * 0.45,
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                   vertical: 30.0,
//                 ),
//                 width: 180.0,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       onChanged: (value) {},
//                       decoration: HomeOverviewScreen.kdecoration.copyWith(
//                         hintText: 'Enter text',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     TextFormField(
//                       onChanged: (value) {
//                         setState(() {
//                           title = value;
//                         });
//                       },
//                       decoration: HomeOverviewScreen.kdecoration.copyWith(
//                         hintText: 'Enter text',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     RaisedButton(
//                       child: Text(
//                         'Add text Field',
//                         style: TextStyle(color: Colors.blue[900]),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           Positioned(
//             bottom: 22.0,
//             left: width * 0.10,
//             child: Row(
//               children: [
//                 if (_hideEditTools)
//                   RaisedButton(
//                     color: Colors.green[800],
//                     onPressed: () async {
//                       await uploadDesign();
//                       // await uploadDesignToFirebaseStorage(context);
//                     },
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Upload design',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 17.0,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5.0,
//                         ),
//                         Icon(
//                           Icons.upload_file,
//                           color: Colors.white,
//                           size: 33.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 SizedBox(
//                   width: _hideEditTools ? width * 0.26 : width * 0.70,
//                 ),
//                 FloatingActionButton(
//                   backgroundColor: Color(0xff892cdc),
//                   onPressed: () {
//                     setState(() {
//                       _hideEditTools = !_hideEditTools;
//                     });
//                   },
//                   child: _hideEditTools
//                       ? Icon(
//                           Icons.cancel,
//                           size: 38.0,
//                         )
//                       : Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                           size: 33.0,
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
