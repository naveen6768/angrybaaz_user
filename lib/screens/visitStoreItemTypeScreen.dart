// import 'dart:html';

import 'package:angrybaaz_user/screens/editingScreen.dart';
import 'package:angrybaaz_user/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:image_picker/image_picker.dart';

class VisitStoreItemType extends StatefulWidget {
  static const id = 'VisitStoreItemType';
  @override
  _VisitStoreItemTypeState createState() => _VisitStoreItemTypeState();
}

class _VisitStoreItemTypeState extends State<VisitStoreItemType> {
  FirebaseFirestore _overallStore = FirebaseFirestore.instance;
  bool hideToggler = false;
  PickedFile _image;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print('image inide _image');
        _image = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List seller_info = ModalRoute.of(context).settings.arguments;
    final String seller_email = seller_info[0].toString();
    final String item_specific_type = seller_info[1].toString();

    Widget buildSlidingPanel({
      @required ScrollController scrollController,
    }) =>
        SingleChildScrollView(
          child: Column(
            children: [
              // if (hideToggler == true)
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '<--Seller Store-->',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              StreamBuilder(
                stream: _overallStore
                    .collection('total_store')
                    .doc('seller')
                    .collection(seller_email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final document = snapshot.data.documents;
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: document.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 7.0,
                          color: Color(0xff41444b),
                          child: ListTile(
                            leading: Container(
                              height: 60.0,
                              width: 60.0,
                              child: Image(
                                image: NetworkImage(
                                  document[index]['item_imageUrl'],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff41444b),
        centerTitle: true,
        title: FutureBuilder(
          future: Database().getName(seller_email),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                snapshot.data.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                ),
              );
            } else {
              return CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              );
            }
          },
        ),
      ),
      body: SlidingUpPanel(
        backdropEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        panelBuilder: (scrollController) => buildSlidingPanel(
          scrollController: scrollController,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await getImage();
                  Navigator.of(context)
                      .pushNamed(EditingScreen.id, arguments: _image);
                  print('yeah');
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(44.0),
                    elevation: 8.0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff81b214),
                      radius: 45.0,
                      child: Icon(
                        Icons.upload_file,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '<-Upload your design->',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                ),
              ),
              // SizedBox(
              //   height: 15.0,
              // ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Divider(
                  height: 2.0,
                  color: Colors.black38,
                ),
              ),
              StreamBuilder(
                stream: _overallStore
                    .collection('item_type_design_imageUrl')
                    .doc('design_url')
                    .collection(item_specific_type)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final document = snapshot.data.documents;
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: document.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Color(0xff1b262c),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 250.0,
                                width: double.infinity,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      document[index]['image_url']),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Start editing',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Lato',
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 900.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
