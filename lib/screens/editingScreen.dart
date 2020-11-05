import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/database.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class EditingScreen extends StatefulWidget {
  static const id = 'Editing Screen';
  @override
  _EditingScreenState createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  double top;
  double left;
  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;
  double _scale = 1.0;
  double _previousScale = 1.0;
  // double _currentRangeValues ;
  RangeValues _currentRangeValues = const RangeValues(0, 20);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final PickedFile _imageImported = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xffcf7500),
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              Offset centerOfGestureDetector =
                  Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
              return GestureDetector(
                dragStartBehavior: DragStartBehavior.start,
                // behavior: HitTestBehavior.translucent,
                onVerticalDragUpdate: (DragUpdateDetails dd) {
                  top = dd.localPosition.dy;
                  left = dd.localPosition.dx;
                  setState(() {});
                },
                onScaleStart: (ScaleStartDetails details) {
                  final touchPositionFromCenter =
                      details.localFocalPoint - centerOfGestureDetector;
                  upsetAngle = oldAngle - touchPositionFromCenter.direction;
                  _previousScale = _scale;
                  setState(() {});
                },
                onScaleUpdate: (ScaleUpdateDetails details) {
                  final touchPositionFromCenter =
                      details.localFocalPoint - centerOfGestureDetector;
                  _scale = _previousScale * details.scale;
                  finalAngle = touchPositionFromCenter.direction + upsetAngle;
                  setState(() {});
                },
                onScaleEnd: (ScaleEndDetails details) {
                  _previousScale = 1.0;
                  oldAngle = finalAngle;
                  setState(() {});
                },
                child: Stack(
                  overflow: Overflow.clip,
                  children: [
                    Container(
                      height: 350.0,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/thelaaz-c9197.appspot.com/o/black_image_for_every_item_type%2Fv-card.png?alt=media&token=2d1798b1-b800-4f5d-968e-6e48040bed0b'),
                      ),
                    ),
                    Positioned(
                      top: top,
                      left: left,
                      child: Transform.rotate(
                        angle: _currentRangeValues.end,
                        child: Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.diagonal3(
                              Vector3(_scale, _scale, _scale)),
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            child: Image.file(
                              File(_imageImported.path),
                            ),
                          ),
                        ),
                      ),

                      //<-->
                      // Positioned(
                      //   top: top,
                      //   left: left,
                      //   child:
                      //       //  Transform.rotate(
                      //       //   angle: finalAngle,
                      //       //   child:
                      //       Transform(
                      //     alignment: FractionalOffset.center,
                      //     transform: Matrix4.diagonal3(
                      //         Vector3(_scale, _scale, _scale),),
                      //     child: Container(
                      //         width: 90.0, height: 90.0, child: Text('data')),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              );
            },
          ),
          RangeSlider(
            activeColor: Colors.white,
            inactiveColor: Theme.of(context).primaryColor,
            values: _currentRangeValues,
            min: 0,
            max: 100,
            divisions: 50,
            onChanged: (RangeValues value) {
              setState(() {
                _currentRangeValues = value;
              });
            },
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              height: 70.0,
              child: Row(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Image.file(
//           File(
//             _imageImported.path,
//           ),
//           fit: BoxFit.cover,
//         ),

// return Form(
//  Stack(
//   children: [

//       Container(
//         color: Colors.red,
//         height: height,
//         child: Center(
//           child: Image.file(
//             File(_image.path),
//           ),
//         ),
//       ),
//       if (_myDesign != null)
//         //added some code
// Container(
//   child:
// ),
//       if (_hideEditTools)
//         Positioned(
//           bottom: 55.0,
//           left: width * 0.45,
//           child: Container(
//             margin: EdgeInsets.symmetric(
//               horizontal: 20.0,
//               vertical: 30.0,
//             ),
//             width: 180.0,
//             child: Column(
//               children: [
//                 TextFormField(
//                   onChanged: (value) {},
//                   decoration: HomeOverviewScreen.kdecoration.copyWith(
//                     hintText: 'Enter text',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 TextFormField(
//                   onChanged: (value) {
//                     setState(() {
//                       title = value;
//                     });
//                   },
//                   decoration: HomeOverviewScreen.kdecoration.copyWith(
//                     hintText: 'Enter text',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 RaisedButton(
//                   child: Text(
//                     'Add text Field',
//                     style: TextStyle(color: Colors.blue[900]),
//                   ),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         ),
//       Positioned(
//         bottom: 22.0,
//         left: width * 0.10,
//         child: Row(
//           children: [
//             if (_hideEditTools)
//               RaisedButton(
//                 color: Colors.green[800],
//                 onPressed: () async {
//                   await uploadDesign();
//                   // await uploadDesignToFirebaseStorage(context);
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Upload design',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 17.0,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5.0,
//                     ),
//                     Icon(
//                       Icons.upload_file,
//                       color: Colors.white,
//                       size: 33.0,
//                     ),
//                   ],
//                 ),
//               ),
//             SizedBox(
//               width: _hideEditTools ? width * 0.26 : width * 0.70,
//             ),
//             FloatingActionButton(
//               backgroundColor: Color(0xff892cdc),
//               onPressed: () {
//                 setState(() {
//                   _hideEditTools = !_hideEditTools;
//                 });
//               },
//               child: _hideEditTools
//                   ? Icon(
//                       Icons.cancel,
//                       size: 38.0,
//                     )
//                   : Icon(
//                       Icons.edit,
//                       color: Colors.white,
//                       size: 33.0,
//                     ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// );
