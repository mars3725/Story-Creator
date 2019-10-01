import 'dart:math';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class CharacterBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  const CharacterBuilderPage(this.data);

  @override
  _CharacterBuilderPageState createState() => _CharacterBuilderPageState();
}

class _CharacterBuilderPageState extends State<CharacterBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;
  Map<String, String> exportFields = {};

  @override
  void initState() {
    super.initState();
    steps = <Step>[
      Step(
          title: Text('Characater Arc'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'beginning',
                    label: 'In the beginning our hero believed'),
                textField(binding: 'end', label: 'By the end our hero believes')
              ]))),
      Step(
          title: Text('Background'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'name', label: 'Name'),
                textField(binding: 'age', label: 'Age'),
                textField(binding: 'sex', label: 'Sex'),
                textField(binding: 'height', label: 'Height'),
                textField(binding: 'bodyType', label: 'Body type'),
                textField(binding: 'nationality', label: 'Nationality'),
                textField(binding: 'birthPlace', label: 'Birth place'),
                textField(binding: 'raised', label: 'Raised'),
                textField(binding: 'languages', label: 'Language/s'),
                textField(binding: 'family', label: 'Family'),
                textField(
                    binding: 'childhoodSocioeconomicLevel',
                    label: 'Socioeconomic level as a child'),
                textField(binding: 'education', label: 'Education'),
              ]))),
      Step(
          title: Text('Current Living Status'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'residence', label: 'Current residence'),
                textField(binding: 'profession', label: 'Current profession'),
                textField(
                    binding: 'socioeconomicLevel',
                    label: 'Current socioeconomic level'),
              ]))),
      Step(
          title: Text('Relationship Status'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'romanticBeliefs', label: 'Romantic beliefs'),
                textField(
                    binding: 'sexualOrientation', label: 'Sexual orientation'),
                textField(binding: 'attraction', label: 'Attraction'),
                textField(
                    binding: 'signifigantOther', label: 'Signifigant other'),
              ]))),
      Step(
          title: Text('Unique Traits'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'talents', label: 'Talents/Skills'),
                textField(binding: 'hobbies', label: 'Hobbies'),
                textField(binding: 'lifeGoal', label: 'Life Goal'),
              ]))),
      Step(
          title: Text('Personality Traits'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'personalityType', label: 'Personality Type'),
                textField(binding: 'intelligence', label: 'Intelligence'),
                textField(binding: 'spirituality', label: 'Spirituality'),
                textField(binding: 'emotionality', label: 'Emotionality'),
                textField(binding: 'coreValues', label: 'Core Values'),
                textField(binding: 'socialValues', label: 'Social Values'),
                textField(
                    binding: 'percievedStrength',
                    label: 'Greatest Percieved Strength'),
                textField(
                    binding: 'actualStrength',
                    label: 'Greatest Actual Strength'),
                textField(
                    binding: 'percievedWeakness',
                    label: 'Greatest Percieved Weakness'),
                textField(
                    binding: 'actualWeakness',
                    label: 'Greatest Actual Weakness'),
                textField(binding: 'innerConflict', label: 'Inner Conflict'),
                textField(binding: 'alignment', label: 'Alignment'),
              ]))),
      Step(
          title: Text('Backstory'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'backstory', label: 'Backstory'),
              ]))),
      Step(
          title: Text('Important Character Notes'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'characterNotes',
                    label: 'Important Character Notes'),
              ]))),
    ];
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
                        child: Text('Character Builder',
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center))),
                RaisedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      String data = '';
                      exportFields.forEach((k,v)=> data+= '$k:\n$v\n\n');
                      Share.share(data);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.blue,
                    child: Icon(Icons.call_made))
              ])),
          LinearProgressIndicator(value: currentStep/(steps.length-1)),
          Expanded(
              child: Form(
                  key: _formKey,
                  child: Stepper(
                      currentStep: currentStep,
                      controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
                      currentStep == steps.length - 1?
                      MaterialButton(
                          onPressed: onStepContinue,
                          child: Text('Finish'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.blue) : Container(),
                      onStepContinue: () {
                        _formKey.currentState.save();
                        if (currentStep == steps.length - 1)
                          saveData()
                              .whenComplete(() => Navigator.of(context).pop());
                        else
                          this.setState(() => currentStep++);
                      },
                      onStepTapped: (step) =>
                          this.setState(() => currentStep = step),
                      steps: steps)))
        ]));
  }

  saveData() async {
    if (widget.data['id'] == null)
      await database.insert(
          'characters', widget.data..['id'] = Random().nextInt(1000000),
          conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('characters', widget.data,
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
          onSaved: (value) {
            widget.data[binding] = value;
            exportFields[label] = value;
          });
}
