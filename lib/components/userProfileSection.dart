import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileSectionDrawer extends StatefulWidget {
  // UserProfileSectionDrawer(this.sellerEmail);
  // final String sellerEmail;

  @override
  _UserProfileSectionDrawerState createState() =>
      _UserProfileSectionDrawerState();
}

class _UserProfileSectionDrawerState extends State<UserProfileSectionDrawer> {
  // FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        '',
        style: const TextStyle(
            color: Colors.black26,
            fontSize: 15.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500),
      ),
      accountEmail: Text(
        _currentUser.email,
        style: const TextStyle(
            color: Color(0xff213e3b),
            fontSize: 15.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500),
      ),
      currentAccountPicture: GestureDetector(
        onTap: () {
          print('pressed');
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
