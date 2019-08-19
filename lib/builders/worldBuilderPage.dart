import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class WorldBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  WorldBuilderPage(this.data);

  @override
  _WorldBuilderPageState createState() => _WorldBuilderPageState();
}

class _WorldBuilderPageState extends State<WorldBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;

  @override
  void initState() {
    super.initState();
    steps = <Step>[
      Step(
          title: Text('Setting'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'name',
                    label: 'Name',
                    tooltip: "This is the name of the entire world, or universe. What ever the name is will have some sort of meaning behind it, even if it's just location the name may be the language of the people who lived or currently live there."),
                textField(binding: 'country', label: 'Country'),
                textField(binding: 'state', label: 'State/Province'),
                textField(binding: 'capital', label: 'Capital/Major'),
                textField(binding: 'resources', label: 'Resources'),
                textField(binding: 'majorLocations', label: 'Major Locations'),
                textField(binding: 'majorLocationsResources', label: 'Major Location Resources'),
                textField(binding: 'climate', label: 'Climate'),
                textField(binding: 'terrain', label: 'Terrain'),
                textField(binding: 'wildlife', label: 'Wildlife'),
                textField(binding: 'flora', label: 'Flora'),
                textField(binding: 'magic', label: 'Technology')
              ]))),
      Step(
          title: Text('Society'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'government', label: 'Government'),
                textField(binding: 'socialSystem', label: 'Social System'),
                textField(binding: 'socialClass', label: 'Social Class'),
                textField(binding: 'religion', label: 'Religion/Beliefs'),
                textField(binding: 'military', label: 'Military'),
                textField(binding: 'races', label: 'Races'),
                textField(binding: 'languages', label: 'Languages'),
                textField(binding: 'food', label: 'Food Supply')
              ]))),
      Step(
          title: Text('Culture'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'art', label: 'Art'),
                textField(binding: 'architecture', label: 'Architecture'),
                textField(binding: 'beliefs', label: 'Cultural Beliefs'),
                textField(binding: 'education', label: 'Education'),
                textField(binding: 'liesure', label: 'Liesure'),
                textField(binding: 'clothing', label: 'Clothing'),
                textField(binding: 'history', label: 'History')
              ])))
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(currentStep);
    return Scaffold(
        body: Column(children: <Widget>[
      Padding(padding: EdgeInsets.only(left: 50, top: 50), child: Align(alignment: Alignment.topLeft, child: GestureDetector(child: Icon(Icons.close, size: 40), onTap: () => Navigator.of(context).pop()))),
      Expanded(
          child: Form(
              key: _formKey,
              child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
                      MaterialButton(onPressed: onStepContinue, child: Text(currentStep == steps.length-1 ? 'Finish' : 'Next'), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), color: Colors.blue),
                  onStepContinue: () {
                    _formKey.currentState.save();
                    if (currentStep == steps.length - 1)
                      saveData().whenComplete(() => Navigator.of(context).pop());
                    else
                      this.setState(() => currentStep++);
                  },
                  onStepTapped: (step) => this.setState(() => currentStep = step),
                  steps: steps)))
    ]));
  }

  Future saveData() async {
    if (widget.data['id'] == null)
      await database.insert('worlds', widget.data..['id'] = Random().nextInt(1000000), conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('worlds', widget.data, where: 'id = ?', whereArgs: [widget.data['id']]);
  }

  TextFormField textField({@required String binding, String label, String tooltip}) => TextFormField(
      maxLines: null,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder(), suffixIcon: tooltip != null ? Tooltip(message: tooltip, showDuration: Duration(seconds: 5), child: Icon(Icons.help)) : null),
      initialValue: widget.data[binding],
      onSaved: (value) => widget.data[binding] = value);
}
