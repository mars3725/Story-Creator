import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class TechnologyBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  const TechnologyBuilderPage(this.data);

  @override
  _TechnologyBuilderPageState createState() => _TechnologyBuilderPageState();
}

class _TechnologyBuilderPageState extends State<TechnologyBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;

  @override
  void initState() {
    super.initState();
    steps = <Step>[
      Step(
          title: Text('Technology Rules'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'name',
                    label: 'What is technology called?',
                    tooltip:
                        "This is what people call Technology. If it has multiple names then this is where you put them. Naming Technology can be influenced by the language of the world, or what it does."),
                textField(
                    binding: 'basedOn', label: 'What is technology based on?'),
                textField(binding: 'what', label: 'What is technology?'),
                Text("How does technology work?"),
                textField(binding: 'energy', label: 'Energy'),
                textField(binding: 'channel', label: 'Channel'),
                textField(binding: 'trigger', label: 'Trigger'),
                textField(binding: 'result', label: 'Result'),
                textField(
                    binding: 'limits',
                    label: 'What are the limits/costs of technology?'),
                textField(
                    binding: 'consequences',
                    label: 'What are the consequences of technology?'),
                textField(binding: 'types', label: 'Types of technology')
              ]))),
      Step(
          title: Text('technology History'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'beginning', label: 'How did technology begin?'),
                textField(
                    binding: 'historicalEvents',
                    label: 'What are the major historical events?'),
                textField(binding: 'who', label: 'Who can use technology?'),
                textField(
                    binding: 'why', label: 'Why can they use technology?'),
                textField(
                    binding: 'whoKnows', label: 'Who knows about technology?'),
                textField(
                    binding: 'whyKnows',
                    label: 'Why do they know about technology?'),
                textField(
                    binding: 'culture',
                    label: 'What is the culture created by technology?'),
                textField(
                    binding: 'governance',
                    label: 'How is the technology governed?')
              ]))),
      Step(
          title: Text('Technology Spine'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(
                    binding: 'called', label: 'In this world, tech is called'),
                textField(binding: 'base', label: 'And is based on'),
                textField(binding: 'application', label: 'You use tech by'),
                textField(binding: 'rules', label: 'The rules of tech are'),
                textField(
                    binding: 'punishment', label: 'If you break the rules'),
                textField(binding: 'variations', label: 'There are also'),
                textField(
                    binding: 'timeline', label: 'Tech has been around since'),
                textField(binding: 'comesFrom', label: 'And comes from'),
                textField(binding: 'practitioners', label: 'It can be used by'),
                textField(
                    binding: 'awareness',
                    label: 'Those who know about tech are'),
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
                    child: Text('Technology Builder',
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
          'technologies', widget.data..['id'] = Random().nextInt(1000000),
          conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('technologies', widget.data,
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
