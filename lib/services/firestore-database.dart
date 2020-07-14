import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workingwithfirebase/home/models/job-model.dart';

class FirestoreDatabase {
  final String uid;
  final _instance = Firestore.instance;
  FirestoreDatabase({this.uid}) : assert(uid != null);

  // create
  Future<void> setJob(JobModel model) async {
    final String path = 'users/$uid/jobs/${model.id}';
    await _instance.document(path).setData(model.toMap());
  }

  // read

  Stream<List<JobModel>> listAllJobs() {
    final String path = 'users/$uid/jobs';
    CollectionReference reference = _instance.collection(path);
    Stream<QuerySnapshot> jobStream = reference.snapshots();
    return jobStream.map(
      (snapshot) => snapshot.documents.map(
        (job) => JobModel.fromMap(job.data,job.documentID),
      ).toList(),
    );
  }
}
