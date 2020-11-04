import 'package:angrybaaz_user/screens/visitStoreItemTypeScreen.dart';
import 'package:angrybaaz_user/services/database.dart';
import 'package:angrybaaz_user/widgets/specificTypeCategory.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemOverviewScreen extends StatefulWidget {
  static const id = 'ItemOverviewScreen';
  @override
  _ItemOverviewScreenState createState() => _ItemOverviewScreenState();
}

class _ItemOverviewScreenState extends State<ItemOverviewScreen> {
  FirebaseFirestore _dataContainer = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String _categoryName = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    final _height = size.height;
    final _width = size.width;
    return Scaffold(
      backgroundColor: Color(0xffd9e4dd),
      appBar: AppBar(
        title: Text(_categoryName),
      ),
      body: StreamBuilder(
        stream: _dataContainer
            .collection('total_store')
            .doc('cat_specific_sellers')
            .collection(_categoryName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final document = snapshot.data.documents;
          return ListView.builder(
            // itemExtent: 200.0,
            itemCount: document.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            document[index]['item_type']
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: _height * 0.30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            document[index]["item_imageUrl"],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0)),
                              color: Color(0xff322f3d),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Price/piece: ' +
                                    'Rs.' +
                                    document[index]['price_per_piece'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          FutureBuilder(
                            future: Database()
                                .getName(document[index]['seller_Email']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  snapshot.data,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black54,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(
                          'Visit Store',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            VisitStoreItemType.id,
                            arguments: [
                              document[index]['seller_Email'],
                              document[index]['item_type']
                            ],

                            // snapshot.data
                          );
                        },
                        // color: Theme.of(context).primaryColor,
                        color: Color(0xffe94560),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
