import 'package:flutter/foundation.dart';

class JobModel {
  final String id;
  final String name;
  final int ratePerHour;
  JobModel(
      {@required this.id, @required this.name, @required this.ratePerHour});

  //  store  to firestore
  Map<String, dynamic> toMap() {
    return {'name': this.name, 'ratePerHour': this.ratePerHour};
  }

  // get from firestore
  factory JobModel.fromMap(Map<String, dynamic> map, String docId) {
    return JobModel(
        name: map['name'], ratePerHour: map['ratePerHour'], id: docId);
  }
}
