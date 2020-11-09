import 'package:Angrybaaz/components/drawerScreen.dart';
import 'package:Angrybaaz/components/userProfileSection.dart';
import 'package:Angrybaaz/screens/loginScreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenDrawer extends StatelessWidget {
  // HomeScreenDrawer(this.sellerEmail);
  // final String sellerEmail;
  final _authInstance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            UserProfileSectionDrawer(),
            Center(
              child: DrawerButtons(
                buttonTitle: 'Home Page',
                buttonIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
            ),
            DrawerButtons(
              buttonTitle: "Track Orders!",
              buttonIcon: Icon(
                Icons.assignment,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'About us',
              buttonIcon: Icon(
                Icons.business_center,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Feedback',
              buttonIcon: Icon(
                Icons.feedback,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Contact us',
              buttonIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Logout',
              buttonIcon: Icon(
                Icons.backspace,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                _authInstance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
