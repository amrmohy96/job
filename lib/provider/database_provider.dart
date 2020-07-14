import 'package:flutter/material.dart';
import 'package:workingwithfirebase/services/firestore-database.dart';

class DatabaseProvider extends InheritedWidget {
  DatabaseProvider({@required this.database, this.child});
  final FirestoreDatabase database;
  final Widget child;

  static FirestoreDatabase of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DatabaseProvider>().database;
  }

  @override
  bool updateShouldNotify(DatabaseProvider oldWidget) {
    return false;
  }
}
