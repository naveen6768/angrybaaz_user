import 'package:angrybaaz_user/screens/homeOverviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/singleCategory.dart';

class HomeOverview extends StatefulWidget {
  @override
  _HomeOverviewState createState() => _HomeOverviewState();
}

class _HomeOverviewState extends State<HomeOverview> {
  FirebaseFirestore _dataStorage = FirebaseFirestore.instance;
  TextEditingController _printerNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder(
            stream: _dataStorage.collection('corousel_images').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final document = snapshot.data.documents;
              return SizedBox(
                height: 250.0,
                width: double.infinity,
                child: Carousel(
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.purple.withOpacity(0.5),
                  borderRadius: true,
                  images: [
                    NetworkImage(document[0]['imageUrl']),
                    NetworkImage(document[1]['imageUrl']),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Customize with us!',
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: _dataStorage.collection('main_category').snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = streamSnapshot.data.documents;

              return Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(

                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   // colors: [Color(0xfff6921e), Color(0xffee4036)],
                    // ),
                    ),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) => SingleCategory(
                    categoryLabel: documents[index]['category_name'],
                    imageUrl: documents[index]['imageUrl'],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            'Get customized with your favorite printing shop?',
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w900,
              fontSize: 15.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _printerNameController,
                      decoration: HomeOverviewScreen.kdecoration.copyWith(
                        hintText: 'Enter shop name',
                        hintStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xffd2e603),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Color(
                          0xff335d2d,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
