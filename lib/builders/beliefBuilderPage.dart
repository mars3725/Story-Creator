import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class BeliefBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  const BeliefBuilderPage(this.data);

  @override
  _BeliefBuilderPageState createState() => _BeliefBuilderPageState();
}

class _BeliefBuilderPageState extends State<BeliefBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;

  @override
  void initState() {
    super.initState();
    steps = <Step>[
      Step(
          title: Text('Religion/Belief Rules'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'name',
                    label: 'Religion/Belief is called?',
                    tooltip:
                        "This is what people call Religion/Belief. If it has multiple names then this is where you put them. Naming your Religion/BeIief can be influenced by the language of the world, or what it is known for."),
                textField(
                    binding: 'ideology',
                    label: 'What is the Religion/Belief ideology?'),
                textField(
                    binding: 'practices',
                    label: "What are the Religion/Belief's practices?"),
                textField(
                    binding: 'laws',
                    label: 'What are the laws of the Religion/Belief?'),
                textField(
                    binding: 'consequences',
                    label: 'What are the consequences of breaking the rules?'),
                textField(
                    binding: 'types', label: 'Other types of Religion/Beliefs')
              ]))),
      Step(
          title: Text('Religion/Belief History'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'beginning',
                    label: 'How did the Religion/Belief begin?'),
                textField(
                    binding: 'historicalEvents',
                    label: 'What are the major historical events?'),
                textField(
                    binding: 'whoWhy',
                    label: 'Who can practice the Religion/Belief and why?'),
                textField(
                    binding: 'whoKnows',
                    label: 'Who knows about the Religion/Belief?'),
                textField(
                    binding: 'culture',
                    label:
                        'What is the culture created by the Religion/Belief?'),
                textField(
                    binding: 'governance',
                    label: 'How is the Religion/Belief governed?')
              ]))),
      Step(
          title: Text('Religion/Belief Spine'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'called',
                    label: 'In this world, belief is called'),
                textField(binding: 'base', label: 'And is based on'),
                textField(
                    binding: 'practitioners', label: 'Believers are called'),
                textField(
                    binding: 'qualifications',
                    label: 'They can practice because'),
                textField(
                    binding: 'application',
                    label: 'They practice their belief by'),
                textField(binding: 'variations', label: 'There are also'),
                textField(
                    binding: 'rules', label: 'The rules of this belief are'),
                textField(
                    binding: 'punishment', label: 'If you break the rules'),
                textField(
                    binding: 'timeline', label: 'Belief has been around since'),
                textField(binding: 'origin', label: 'And comes from'),
                textField(
                    binding: 'awareness',
                    label: 'The people who know about this belief are'),
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
                    child: Text('Belief Builder',
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
          'beliefs', widget.data..['id'] = Random().nextInt(1000000),
          conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('beliefs', widget.data,
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
