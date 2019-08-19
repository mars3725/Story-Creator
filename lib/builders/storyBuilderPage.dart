import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class StoryBuilderPage extends StatefulWidget {
  final Map<String, Object> data;

  const StoryBuilderPage(this.data);

  @override
  _StoryBuilderPageState createState() => _StoryBuilderPageState();
}

class _StoryBuilderPageState extends State<StoryBuilderPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  List<Step> steps;


  @override
  void initState() {
    super.initState();
    steps = <Step>[
      Step(
          title: Text('Idea'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'title', label: 'title'),
                textField(
                    binding: 'idea',
                    label: 'What if...',
                    tooltip: "An idea is anything. It's the spark that can become a story and it doesn't matter what that spark is. The important thing about an idea or a concept is that whatever it is, it plants a seed. If you can't imagine anything about an idea, or it doesn't excite you in any way, then find another. But if the idea ignites something within you and makes you think, then it's a good idea. The development and execution of the idea is what will make the idea grow into something great. \n It begins with a what if statement. The possibilities are literally endless and can range from silly to serious. Any concept can fit into any genre, any idea can become any type of story, and all that matters is that it means something to you. Coming up with an idea can come in a variety of forms. If uninspired, then talk to others, watch film, media, go on a vacation. Find something you are passionate about for good or bad, and start there."),
                textField(binding: 'experience', label: 'What experience do you want your audience to be left with?')
              ]))),
      Step(
          title: Text('Setting'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'whenSetting', label: 'WHEN: What year? What time period or era?'),
                textField(binding: 'whereSetting', label: 'WHERE: What universe? Planet? Country? State? Town?'),
                textField(binding: 'whatSetting', label: 'WHAT: What makes the place unique?'),
                textField(binding: 'whySetting', label: 'WHY: Why this world and not another?')
              ]))),
      Step(
          title: Text('Characters: Protagonist'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'protagonistWho', label: 'Name, Sex, Age, Race, Profession'),
                textField(binding: 'protagonistActualStrength', label: 'What is their actual strength?'),
                textField(binding: 'protagonistActualStrengthReason', label: 'Why do they ACTUALLY have this strength?'),
                textField(binding: 'protagonistInnerConflict', label: 'What are they struggling with?'),
                textField(binding: 'protagonistConflictReason', label: 'Why are they struggling?'),
                textField(binding: 'protagonistEstablishedNorm', label: 'What are they doing now?'),
                textField(binding: 'protagonistGoal', label: 'What does the protagonist want?'),
                textField(binding: 'protagonistDistinctiveness', label: 'What makes them dynamic?')
              ]))),
      Step(
          title: Text('Characters: Deuteragonist'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'deuteragonistWho', label: 'Name, Sex, Age, Race, Profession'),
                textField(binding: 'deuteragonistActualStrength', label: 'What is their actual strength?'),
                textField(binding: 'deuteragonistActualStrengthReason', label: 'Why do they ACTUALLY have this strength?'),
                textField(binding: 'deuteragonistPercievedStrength', label: 'What is their percieved strength?'),
                textField(binding: 'deuteragonistPercievedStrengthReason', label: 'Why do they THINK they have this strength?'),
                textField(binding: 'deuteragonistInnerConflict', label: 'What are they struggling with?'),
                textField(binding: 'deuteragonistConflictReason', label: 'Why are they struggling?'),
                textField(binding: 'deuteragonistEstablishedNorm', label: 'What are they doing now?'),
                textField(binding: 'deuteragonistGoal', label: 'What does the deuteragonist want?'),
                textField(binding: 'deuteragonistSignifigance', label: 'Why is this character important to the protagonist?'),
                textField(binding: 'deuteragonistSimilarity', label: 'How does the deuteragonist relate to the protagonist?')
              ]))),
      Step(
          title: Text('Characters: Tertiary'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'tertiaryWho', label: 'Name, Sex, Age, Race, Profession'),
                textField(binding: 'tertiaryActualStrength', label: 'What is their actual strength?'),
                textField(binding: 'tertiaryActualStrengthReason', label: 'Why do they ACTUALLY have this strength?'),
                textField(binding: 'tertiaryPercievedStrength', label: 'What is their percieved strength?'),
                textField(binding: 'tertiaryPercievedStrengthReason', label: 'Why do they THINK they have this strength?'),
                textField(binding: 'tertiaryInnerConflict', label: 'What are they struggling with?'),
                textField(binding: 'tertiaryConflictReason', label: 'Why are they struggling?'),
                textField(binding: 'tertiaryEstablishedNorm', label: 'What are they doing now?'),
                textField(binding: 'tertiaryGoal', label: 'What does the tertiary character want?'),
                textField(binding: 'tertiarySignifigance', label: 'Why is this character important to the protagonist?'),
                textField(binding: 'tertiarySimilarity', label: 'How does the deuteragonist relate to the protagonist?')
              ]))),
      Step(
          title: Text('Characters: Antagonist'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                textField(binding: 'antagonistWho', label: 'Name, Sex, Age, Race, Profession'),
                textField(binding: 'antagonistActualStrength', label: 'What is their actual strength?'),
                textField(binding: 'antagonistActualStrengthReason', label: 'Why do they ACTUALLY have this strength?'),
                textField(binding: 'antagonistPercievedStrength', label: 'What is their percieved strength?'),
                textField(binding: 'antagonistPercievedStrengthReason', label: 'Why do they THINK they have this strength?'),
                textField(binding: 'antagonistInnerConflict', label: 'What are they struggling with?'),
                textField(binding: 'antagonistConflictReason', label: 'Why are they struggling?'),
                textField(binding: 'antagonistEstablishedNorm', label: 'What are they doing now?'),
                textField(binding: 'antagonistGoal', label: 'What does the tertiary character want?'),
                textField(binding: 'antagonistSignifigance', label: 'Why is this character important to the protagonist?'),
                textField(binding: 'antagonistSimilarity', label: 'How does the antagonist relate to the protagonist?'),
                textField(binding: 'antagonistDistinctiveness', label: 'What makes them dynamic?')
              ]))),
      Step(
          title: Text('Intention'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('HERO: Who is the audience following through the story?'),
                textField(binding: 'aPlotHero', label: 'A Plot'),
                textField(binding: 'bPlotHero', label: 'B Plot'),
                textField(binding: 'cPlotHero', label: 'C Plot'),
                Text('Objective: What is the immediate goal that they will either succeed or fail at by the end of the story?'),
                textField(binding: 'aPlotObjective', label: 'A Plot'),
                textField(binding: 'bPlotObjective', label: 'B Plot'),
                textField(binding: 'cPlotObjective', label: 'C Plot'),
              ]))),
      Step(
          title: Text('Obstacle'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('Villian: The group, person, event, system, condition, or location that hinders them'),
                textField(binding: 'aPlotVillian', label: 'A Plot'),
                textField(binding: 'bPlotVillian', label: 'B Plot'),
                textField(binding: 'cPlotVillian', label: 'C Plot'),
                Text('Reason: Why is this a hinderance?'),
                textField(binding: 'aPlotVillianReason', label: 'A Plot'),
                textField(binding: 'bPlotVillianReason', label: 'B Plot'),
                textField(binding: 'cPlotVillianReason', label: 'C Plot'),
              ]))),
      Step(
          title: Text('Stakes'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('What happens if the hero fails and/or succeeds?'),
                textField(binding: 'aPlotStakes', label: 'A Plot'),
                textField(binding: 'bPlotStakes', label: 'B Plot'),
                textField(binding: 'cPlotStakes', label: 'C Plot'),
              ]))),
      Step(
          title: Text('Resolution'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('What is the resolution to the characters stories?'),
                textField(binding: 'aPlotCharacterResolution', label: 'A Plot'),
                textField(binding: 'bPlotCharacterResolution', label: 'B Plot'),
                textField(binding: 'cPlotCharacterResolution', label: 'C Plot'),
              ]))),
      Step(
          title: Text('Beginning: Exposition'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('SETTING: Introduce the setting and established norm'),
                textField(binding: 'aPlotSetting', label: 'A Plot'),
                textField(binding: 'bPlotSetting', label: 'B Plot'),
                textField(binding: 'cPlotSetting', label: 'C Plot'),
                Text('CHARACTERS: Introduce the characters'),
                textField(binding: 'aPlotCharacters', label: 'A Plot'),
                textField(binding: 'bPlotCharacters', label: 'B Plot'),
                textField(binding: 'cPlotCharacters', label: 'C Plot'),
                Text("CHARACTERS: Introduce the character's goals"),
                textField(binding: 'aPlotGoals', label: 'A Plot'),
                textField(binding: 'bPlotGoals', label: 'B Plot'),
                textField(binding: 'cPlotGoals', label: 'C Plot'),
                Text("INCITING INCIDENT: Introduce the character's intention, obstacle, and stakes"),
                textField(binding: 'aPlotIncident', label: 'A Plot'),
                textField(binding: 'bPlotIncident', label: 'B Plot'),
                textField(binding: 'cPlotIncident', label: 'C Plot'),
              ]))),
      Step(
          title: Text('Middle: Conflict'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('RISING ACTION: What events occur that directly affect the characters?'),
                textField(binding: 'aPlotRisingAction', label: 'A Plot'),
                textField(binding: 'bPlotRisingAction', label: 'B Plot'),
                textField(binding: 'cPlotRisingAction', label: 'C Plot'),
                Text('REASON: How do these events advance the plot?'),
                textField(binding: 'aPlotReason', label: 'A Plot'),
                textField(binding: 'bPlotReason', label: 'B Plot'),
                textField(binding: 'cPlotReason', label: 'C Plot'),
                Text("RISING REACTION: What are the consequences of these actions?"),
                textField(binding: 'aPlotReaction', label: 'A Plot'),
                textField(binding: 'bPlotReaction', label: 'B Plot'),
                textField(binding: 'cPlotReaction', label: 'C Plot'),
                Text("CLIMAX: What is the turning point of the story?"),
                textField(binding: 'aPlotClimax', label: 'A Plot'),
                textField(binding: 'bPlotClimax', label: 'B Plot'),
                textField(binding: 'cPlotClimax', label: 'C Plot'),
              ]))),
      Step(
          title: Text('End: Conclusion'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('FALLING ACTION: What is the final action the characters take to achieve their intention?'),
                textField(binding: 'aPlotFallingAction', label: 'A Plot'),
                textField(binding: 'bPlotFallingAction', label: 'B Plot'),
                textField(binding: 'cPlotFallingAction', label: 'C Plot'),
                Text('CONSEQUENCE: What is the result of the falling action and why?'),
                textField(binding: 'aPlotConsequence', label: 'A Plot'),
                textField(binding: 'bPlotConsequence', label: 'B Plot'),
                textField(binding: 'cPlotConsequence', label: 'C Plot'),
                Text("RESOLUTION: What has changed in the protagonist? What will they do now?"),
                textField(binding: 'aPlotResolution', label: 'A Plot'),
                textField(binding: 'bPlotResolution', label: 'B Plot'),
                textField(binding: 'cPlotResolution', label: 'C Plot'),
              ]))),
      Step(
          title: Text('Reference Tools: Linear Story Arc'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('Beginning'),
                textField(binding: 'characters', label: 'This is a story about'),
                textField(binding: 'goals', label: 'Normally'),
                textField(binding: 'incitingIncident', label: 'One day'),
                textField(binding: 'incitingIncidentReason', label: 'Because'),
                textField(binding: 'intention', label: 'Which Means'),
                Text('Middle'),
                textField(binding: 'risingAction', label: 'Because of that'),
                textField(binding: 'risingActionReason', label: 'Because'),
                textField(binding: 'risingReaction', label: 'Because of that'),
                textField(binding: 'risingReactionReason', label: 'Which Means'),
                Text('End'),
                textField(binding: 'fallingAction', label: 'Because of that'),
                textField(binding: 'fallingActionReason', label: 'Because'),
                textField(binding: 'resolution', label: 'Until Finally'),
                textField(binding: 'resolutionReason', label: 'Because'),
              ]))),
      Step(
          title: Text('Reference Tools: Continued'),
          content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Wrap(runSpacing: 20, children: <Widget>[
                Text('Baby Arc'),
                textField(binding: 'beginning', label: 'In the beginning'),
                textField(binding: 'middle', label: 'During the middle'),
                textField(binding: 'end', label: 'By the end'),
                textField(binding: 'synopsis', label: 'Synopsis'),
                textField(binding: 'logLine', label: 'Log Line'),
                textField(binding: 'tagLine', label: 'Tag Line'),
                textField(binding: 'theme', label: 'Theme(s)'),
              ])))
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(currentStep);
    return Scaffold(
        body: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 50, top: 50, right: 50),
              child: Row(children: <Widget>[
                Align(alignment: Alignment.topLeft,
                    child: GestureDetector(
                        child: Icon(Icons.close, size: 40), onTap: () => Navigator.of(context).pop())),
                Expanded(child: Center(child: Text('Story Builder', style: TextStyle(fontSize: 24)))),
                RaisedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/archiveSelection'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    color: Colors.orange,
                    child: Icon(Icons.archive))
              ])),      Expanded(
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

  saveData() async {
    if (widget.data['id'] == null)
      await database.insert('stories', widget.data..['id'] = Random().nextInt(1000000), conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await database.update('stories', widget.data, where: 'id = ?', whereArgs: [widget.data['id']]);
  }

  TextFormField textField({@required String binding, String label, String tooltip}) => TextFormField(
      maxLines: null,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder(), suffixIcon: tooltip != null ? Tooltip(message: tooltip, showDuration: Duration(seconds: 5), child: Icon(Icons.help)) : null),
      initialValue: widget.data[binding],
      onSaved: (value) => widget.data[binding] = value);
}
