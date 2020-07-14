import 'package:flutter/material.dart';
import 'package:workingwithfirebase/home/jobs/edit-job-page.dart';
import 'package:workingwithfirebase/home/jobs/empty-content.dart';
import 'package:workingwithfirebase/home/jobs/job-list-tile.dart';
import 'package:workingwithfirebase/home/jobs/list-item-builder.dart';
import 'package:workingwithfirebase/home/models/job-model.dart';
import 'package:workingwithfirebase/platform/platform-alert-dialog.dart';
import 'package:workingwithfirebase/provider/auth-provider.dart';
import 'package:workingwithfirebase/provider/database_provider.dart';

class Jobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fire = DatabaseProvider.of(context);
    fire.listAllJobs();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('jobs Page', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => confirmSignOut(context),
              icon: Icon(Icons.close, color: Colors.white),
              label: Text('signout', style: TextStyle(color: Colors.white))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final db = DatabaseProvider.of(context);
    return StreamBuilder<List<JobModel>>(
      stream: db.listAllJobs(),
      builder: (context, AsyncSnapshot<List<JobModel>> snapshot) {
        return ListItemBuilder<JobModel>(
          snapshot: snapshot,
          itemBuilder: (context, job) => JobListTile(
            jobmodel: job,
            onPressed: () => EditJobPage.show(context, job: job),
          ),
        );
      },
    );
  }

  // ignore: unused_element
  Future<void> _createJob(BuildContext context) async {
    final fire = DatabaseProvider.of(context);
    await fire.setJob(JobModel(name: 'flutter', ratePerHour: 120, id: 'test'));
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final auth = AuthProvider.of(context);
    final sign = await PlatformAlertDialog(
      title: 'sign-out',
      content: 'Are you sure ?',
      actionText: 'ok',
      cancel: 'cancel',
    ).show(context);
    if (sign == true) {
      await auth.signOut();
    }
  }
}
