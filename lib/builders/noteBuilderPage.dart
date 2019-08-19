import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class NoteBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  const NoteBuilderPage(this.data);

  @override
  _NoteBuilderPageState createState() => _NoteBuilderPageState();
}

class _NoteBuilderPageState extends State<NoteBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(currentStep);
    return Scaffold(
        body: Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(left: 50, top: 50, right: 50),
          child: Row(children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    child: Icon(Icons.close, size: 40),
                    onTap: () => Navigator.of(context).pop())),
            Expanded(
                child: Center(
                    child: Text('Note Builder',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center))),
            RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/archiveSelection'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Colors.orange,
                child: Icon(Icons.archive))
          ])),
      Expanded(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                textField(binding: 'title', label: 'Title'),
                Container(height: 50),
                Expanded(
                    child: TextFormField(
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Note',
                            border: OutlineInputBorder()),
                        initialValue: widget.data['note'],
                        onSaved: (value) => widget.data['note'] = value)),
                MaterialButton(
                    onPressed: () {
                      saveData();
                      Navigator.of(context).pop();
                    },
                    child: Text('Finish'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.blue),
              ])))
    ]));
  }

  saveData() async {
    if (widget.data['id'] == null)
      await database.insert(
          'notes', widget.data..['id'] = Random().nextInt(1000000),
          conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('notes', widget.data,
          where: 'id = ?', whereArgs: [widget.data['id']]);
  }

  TextFormField textField(
          {@required String binding, String label, String tooltip}) =>
      TextFormField(
          maxLines: null,
          decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
              suffixIcon: tooltip != null
                  ? Tooltip(
                      message: tooltip,
                      showDuration: Duration(seconds: 5),
                      child: Icon(Icons.help))
                  : null),
          initialValue: widget.data[binding],
          onSaved: (value) => widget.data[binding] = value);
}
