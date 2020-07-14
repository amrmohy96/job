import 'package:flutter/material.dart';
import 'package:workingwithfirebase/home/models/job-model.dart';

class JobListTile extends StatelessWidget {
  final JobModel jobmodel;
  final Function onPressed;

  const JobListTile({this.jobmodel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          jobmodel.name,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              letterSpacing: 1.3),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: onPressed,
      ),
    );
  }
}
