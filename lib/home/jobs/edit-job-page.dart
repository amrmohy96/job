import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workingwithfirebase/home/models/job-model.dart';
import 'package:workingwithfirebase/platform/platform-alert-dialog.dart';
import 'package:workingwithfirebase/platform/platform-exception-alert-dialog.dart';
import 'package:workingwithfirebase/provider/database_provider.dart';
import 'package:workingwithfirebase/services/firestore-database.dart';

class EditJobPage extends StatefulWidget {
  final FirestoreDatabase database;
  final JobModel jobModel;
  EditJobPage({@required this.database, this.jobModel});

  static Future<void> show(BuildContext context, {JobModel job}) async {
    final db = DatabaseProvider.of(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EditJobPage(
                database: db,
                jobModel: job,
              ),
          fullscreenDialog: true),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  FirestoreDatabase get database => widget.database;
  JobModel get job => widget.jobModel;
  String _name;
  int _rate;

  @override
  void initState() {
    super.initState();
    if (job == null) {
    } else {
      _name = job.name;
      _rate = job.ratePerHour;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
        title: Text(job == null ? ' new Job' : 'edit job',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: _submit,
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  bool _validSave() {
    bool valid = _formkey.currentState.validate();
    if (valid == true) {
      _formkey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> _submit() async {
    if (_validSave()) {
      try {
        List<String> names = [];
        final jobs = await database.listAllJobs().first;
        final alljobs = jobs.map((e) => e.name).toList();
        names = alljobs;
        if (job != null) {
          names.remove(job.name);
        }
        if (names.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name Already used',
            content: 'please choose diff name',
            actionText: 'ok',
          ).show(context);
          Future.delayed(
              Duration(seconds: 2), () => _formkey.currentState.reset());
        } else {
          final id = job?.id ?? DateTime.now().toIso8601String();
          final jobx = JobModel(name: _name, ratePerHour: _rate, id: id);
          await database.setJob(jobx);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(title: 'err', exception: e).show(context);
      }
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: _formChildren(),
      ),
    );
  }

  List<Widget> _formChildren() {
    return [
      TextFormField(
          initialValue: _name,
          decoration: InputDecoration(labelText: 'job name'),
          onSaved: (val) => _name = val,
          validator: (val) => val.isNotEmpty ? null : 'name can\'t be Empty'),
      TextFormField(
        initialValue: _rate != null ? '$_rate' : null,
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        onSaved: (val) => _rate = int.tryParse(val) ?? 0,
        validator: (val) => val.isNotEmpty ? null : 'rate can\'t be Empty',
        decoration: InputDecoration(
          labelText: 'ratePerHour',
        ),
      )
    ];
  }
}
