import 'package:flutter/material.dart';
import 'package:workingwithfirebase/home/jobs/jobs.dart';
import 'package:workingwithfirebase/models/user.dart';
import 'package:workingwithfirebase/pages/sign-in-page.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';
import 'package:workingwithfirebase/provider/database_provider.dart';
import 'package:workingwithfirebase/services/firestore-database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return StreamBuilder<User>(
      stream: auth.onAuth,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          } else {
            return DatabaseProvider(
              database: FirestoreDatabase(uid: user.uid),
              child: Jobs(),
            );
          }
        }
      },
    );
  }
}
