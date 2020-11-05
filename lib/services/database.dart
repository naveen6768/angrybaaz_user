import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final _firestore = FirebaseFirestore.instance;
  Future<String> getName(String sellerEmail) async {
    String retVal;

    try {
      DocumentSnapshot doc =
          await _firestore.collection('seller').doc(sellerEmail).get();
      retVal = doc.data()['shop_name'];
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> getImageUrl(String mainCategoryName) async {
    String retImageUrl;
    try {
      DocumentSnapshot docPointer = await _firestore
          .collection('admin_blank_designs')
          .doc(mainCategoryName)
          .get();
      retImageUrl = docPointer.data()['imageUrl'];
    } catch (e) {
      print(e);
    }
    return retImageUrl;
  }
}
