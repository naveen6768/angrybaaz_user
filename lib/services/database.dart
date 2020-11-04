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

  // Future<Map> getStore(String sellerEmail) async {
  //   Map retVal;
  //   try{
  //     DocumentSnapshot doc = await _firestore.collection('total_store').doc('seller').collection(sellerEmail).doc().get();
  //   }
  // }
}
