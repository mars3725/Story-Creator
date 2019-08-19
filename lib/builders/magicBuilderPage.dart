import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class MagicBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  const MagicBuilderPage(this.data);

  @override
  _MagicBuilderPageState createState() => _MagicBuilderPageState();
}

class _MagicBuilderPageState extends State<MagicBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;

  @override
  void initState() {
    super.initState();
    steps = <Step>[
      Step(
          title: Text('Magic Rules'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'name',
                    label: 'What is magic called?',
                    tooltip:
                        "This is what people call magic. If it has multiple names then this is where you put them. Naming magic can be influenced by the language of the world, or what it does. For example you can name magic \"Frosting\" if the magic is uses snow and ice to \"Frost\" things. Or it could be called Fijor, if the magic is for a race of people that speak a slightly Swedish sounding language."),
                textField(binding: 'basedOn', label: 'What is magic based on?'),
                textField(binding: 'what', label: 'What is magic?'),
                Text("How does magic work?"),
                textField(binding: 'energy', label: 'Energy'),
                textField(binding: 'channel', label: 'Channel'),
                textField(binding: 'trigger', label: 'Trigger'),
                textField(binding: 'result', label: 'Result'),
                textField(
                    binding: 'limits', label: 'What are the limits of magic?'),
                textField(
                    binding: 'consequences',
                    label: 'What are the consequences of magic?'),
                textField(binding: 'types', label: 'Types of magic')
              ]))),
      Step(
          title: Text('Magic History'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'beginning', label: 'How did magic begin?'),
                textField(
                    binding: 'historicalEvents',
                    label: 'What are the major historical events?'),
                textField(binding: 'who', label: 'Who can use magic?'),
                textField(binding: 'why', label: 'Why can they use magic?'),
                textField(binding: 'whoKnows', label: 'Who knows about magic?'),
                textField(
                    binding: 'whyKnows',
                    label: 'Why do they know about magic?'),
                textField(
                    binding: 'culture',
                    label: 'What is the culture created by magic?'),
                textField(
                    binding: 'governance', label: 'How is magic governed?')
              ]))),
      Step(
          title: Text('Magic Spine'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'called', label: 'In this world, magic is called'),
                textField(binding: 'base', label: 'And is based on'),
                textField(binding: 'comesFrom', label: 'Magic comes from'),
                textField(
                    binding: 'practitioners',
                    label: 'practitioners are called'),
                textField(
                    binding: 'qualifications',
                    label: 'They can practice because'),
                textField(binding: 'application', label: 'They use magic by'),
                textField(binding: 'variations', label: 'There are also'),
                textField(binding: 'rules', label: 'The rules of magic are'),
                textField(
                    binding: 'punishment', label: 'If you break the rules'),
                textField(
                    binding: 'timeline', label: 'Magic has been around since'),
                textField(
                    binding: 'awareness',
                    label: 'The people who know about magic are'),
                textField(binding: 'reason', label: 'because'),
                textField(binding: 'life', label: 'Which creates'),
                textField(binding: 'rulingBody', label: 'And is governed by')
              ])))
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
                    child: Text('Magic Builder',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center)))
          ])),
      Expanded(
          child: Form(
              key: _formKey,
              child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
                      MaterialButton(
                          onPressed: onStepContinue,
                          child: Text(currentStep == steps.length - 1
                              ? 'Finish'
                              : 'Next'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.blue),
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
          'magic', widget.data..['id'] = Random().nextInt(1000000),
          conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('magic', widget.data,
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
