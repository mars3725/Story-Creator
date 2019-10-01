import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'archiveSelectionPage.dart';
import 'builderSelectionPage.dart';
import 'builders/beliefBuilderPage.dart';
import 'builders/characterBuilderPage.dart';
import 'builders/magicBuilderPage.dart';
import 'builders/noteBuilderPage.dart';
import 'builders/storyBuilderPage.dart';
import 'builders/technologyBuilderPage.dart';
import 'builders/worldBuilderPage.dart';
import 'buttons.dart';
import 'guidesPage.dart';
import 'selectors/beliefSelectionPage.dart';
import 'selectors/characterSelectionPage.dart';
import 'selectors/magicSelectionPage.dart';
import 'selectors/noteSelectionPage.dart';
import 'selectors/storySelectionPage.dart';
import 'selectors/technologySelectionPage.dart';
import 'selectors/worldSelectionPage.dart';


Database database;

void main() {
  _openDatabase().then((db) {
    database = db;
    runApp(MyApp());
  });
}

Future<Database> _openDatabase() async {
  return await openDatabase(join(await getDatabasesPath(), 'data.db'),
      version: 1, onCreate: (db, version) {
        return Future.wait([
          db.execute(
              "CREATE TABLE worlds(id INTEGER PRIMARY KEY, name TEXT, country TEXT, state TEXT, capital TEXT, resources TEXT, majorLocations TEXT, majorLocationsResources TEXT, climate TEXT, terrain TEXT, wildlife TEXT, flora TEXT, magic TEXT, government TEXT, socialSystem TEXT, socialClass TEXT, religion TEXT, military TEXT, races TEXT, languages TEXT, food TEXT, art TEXT, architecture TEXT, beliefs TEXT, education TEXT, liesure TEXT, clothing TEXT, history TEXT)"),
          db.execute(
              "CREATE TABLE magic(id INTEGER PRIMARY KEY, name TEXT, basedOn TEXT, what TEXT, energy TEXT, channel TEXT, trigger TEXT, result TEXT, limits TEXT, consequences TEXT, types TEXT, beginning TEXT, historicalEvents TEXT, who TEXT, why TEXT, whoKnows TEXT, whyKnows TEXT, culture TEXT, governance TEXT, called TEXT, base TEXT, comesFrom TEXT, practitioners TEXT, qualifications TEXT, application TEXT, variations TEXT, rules TEXT, punishment TEXT, timeline TEXT, awareness TEXT, reason TEXT, life TEXT, rulingBody TEXT)"),
          db.execute(
              "CREATE TABLE technologies(id INTEGER PRIMARY KEY, name TEXT, basedOn TEXT, what TEXT, energy TEXT, channel TEXT, trigger TEXT, result TEXT, limits TEXT, consequences TEXT, types TEXT, beginning TEXT, historicalEvents TEXT, who TEXT, why TEXT, whoKnows TEXT, whyKnows TEXT, culture TEXT, governance TEXT, called TEXT, base TEXT, application TEXT, rules TEXT, punishment TEXT, variations TEXT, timeline TEXT, comesFrom TEXT, practitioners TEXT, awareness TEXT, reason TEXT, life TEXT, rulingBody TEXT)"),
          db.execute(
              "CREATE TABLE beliefs(id INTEGER PRIMARY KEY, name TEXT, ideology TEXT, practices TEXT, laws TEXT, consequences TEXT, types TEXT, beginning TEXT, historicalEvents TEXT, whoWhy TEXT, whoKnows TEXT, culture TEXT, governance TEXT, called TEXT, base TEXT, practitioners TEXT, qualifications TEXT, application TEXT, variations TEXT, rules TEXT, punishment TEXT, timeline TEXT, origin TEXT, awareness TEXT, reason TEXT, life TEXT, rulingBody TEXT)"),
          db.execute(
              "CREATE TABLE characters(id INTEGER PRIMAY KEY, beginning TEXT, end TEXT, name TEXT, age TEXT, sex TEXT, height TEXT, bodyType TEXT, nationality TEXT, birthPlace TEXT, raised TEXT, languages TEXT, family TEXT, childhoodSocioeconomicLevel TEXT, education TEXT, residence TEXT, profession TEXT, socioeconomicLevel TEXT, romanticBeliefs TEXT, sexualOrientation TEXT, attraction TEXT, signifigantOther TEXT, talents TEXT, hobbies TEXT, lifeGoal TEXT, personalityType TEXT, intelligence TEXT, spirituality TEXT, emotionality TEXT, coreValues TEXT, socialValues TEXT, percievedStrength TEXT, actualStrength TEXT, percievedWeakness TEXT, actualWeakness TEXT, innerConflict TEXT, alignment TEXT, backstory TEXT, characterNotes TEXT)"),
          db.execute(
              "CREATE TABLE notes(id INTEGER PRIMAY KEY, title TEXT, note TEXT)"),
          db.execute(
              "CREATE TABLE stories(id INTEGER PRIMAY KEY, title TEXT, idea TEXT, experience TEXT, whenSetting TEXT, whereSetting TEXT, whatSetting TEXT, whySetting TEXT, protagonistWho TEXT, protagonistActualStrength TEXT, protagonistActualStrengthReason TEXT, protagonistInnerConflict TEXT, protagonistEstablishedNorm TEXT, protagonistGoal TEXT, protagonistDistinctiveness TEXT, deuteragonistWho TEXT, deuteragonistActualStrength TEXT, deuteragonistActualStrengthReason TEXT, deuteragonistPercievedStrength TEXT, deuteragonistPercievedStrengthReason TEXT, deuteragonistInnerConflict TEXT, deuteragonistConflictReason TEXT, deuteragonistEstablishedNorm TEXT, deuteragonistGoal TEXT, deuteragonistSignifigance TEXT, deuteragonistSimilarity TEXT, tertiaryWho TEXT, tertiaryActualStrength TEXT, tertiaryActualStrengthReason TEXT, tertiaryPercievedReason TEXT, tertiaryPercievedStrengthReason TEXT, tertiaryInnerConflict TEXT, tertiaryInnerConflictReason TEXT, tertiaryEstablishedNorm TEXT, tertiaryGoal TEXT, tertiarySignifigance TEXT, tertiarySimilarity TEXT, antagonistWho TEXT, antagonistActualStrength TEXT, antagonistActualStrengthReason TEXT, antagonistPercievedStrength TEXT, antagonistPercievedStrengthReason TEXT, antagonistInnerConflict TEXT, antagonistEstablishedNorm TEXT, antagonistGoal TEXT, antagonistSignifigance TEXT, antagonistSimilarity TEXT, antagonistDistinctiveness TEXT,  aPlotHero TEXT, bPlotHero TEXT, cPlotHero TEXT, aPlotObjective TEXT, bPlotObjective TEXT, cPlotObjective TEXT, aPlotVillian TEXT, bPlotVillian TEXT, cPlotVillian TEXT, aPlotVillianReason TEXT, bPlotVillianReason TEXT, cPlotVillianReason TEXT, aPlotStakes TEXT, bPlotStakes TEXT, cPlotStakes TEXT, aPlotCharacterResolution TEXT, bPlotCharacterResolution TEXT, cPlotCharacterResolution TEXT, aPlotSetting TEXT, bPlotSetting TEXT, cPlotSetting TEXT, aPlotCharacters TEXT, bPlotCharacters TEXT, cPlotCharacters TEXT, aPlotGoals TEXT, bPlotGoals TEXT, cPlotGoals TEXT, aPlotIncident TEXT, bPlotIncident TEXT, cPlotIncident TEXT, aPlotRisingAction TEXT, bPlotRisingAction TEXT, cPlotRisingAction TEXT, aPlotReason TEXT, bPlotReason TEXT, cPlotReason TEXT, aPlotReaction TEXT, bPlotReaction TEXT, cPlotReaction TEXT, aPlotClimax TEXT, bPlotClimax TEXT, cPlotClimax TEXT, aPlotFallingAction TEXT, bPlotFallingAction TEXT, cPlotFallingAction TEXT, aPlotConsequence TEXT, bPlotConsequence TEXT, cPlotConsequence TEXT, aPlotResolution TEXT, bPlotResolution TEXT, cPlotResolution TEXT, characters TEXT, goals TEXT, incitingIncident TEXT, incitingIncidentReason TEXT, intention TEXT, risingAction TEXT, risingActionReason TEXT, risingReaction TEXT, risingReactionReason TEXT, fallingAction TEXT, fallingActionReason TEXT, resolution TEXT, resolutionReason TEXT, beginning TEXT, middle TEXT, end TEXT, synopsis TEXT, logLine TEXT, tagLine TEXT, theme TEXT)")
        ]);
      });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Story Creator',
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Courier'),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MenuPage(),
          '/storySelection': (context) => StorySelectionPage(),
          '/archiveSelection': (context) => ArchiveSelectionPage(),
          '/builderSelection': (context) => BuilderSelectionPage(),
          '/guides': (context) => GuidesPage(),
          '/characterBuilder': (context) => CharacterBuilderPage({}),
          '/noteBuilder': (context) => NoteBuilderPage({}),
          '/worldSelection': (context) => WorldSelectionPage(),
          '/magicSelection': (context) => MagicSelectionPage(),
          '/technologySelection': (context) => TechnologySelectionPage(),
          '/beliefSelection': (context) => BeliefSelectionPage(),
          '/characterSelection': (context) => CharacterSelectionPage(),
          '/noteSelection': (context) => NoteSelectionPage(),
          '/worldBuilder': (context) => WorldBuilderPage({}),
          '/magicBuilder': (context) => MagicBuilderPage({}),
          '/technologyBuilder': (context) => TechnologyBuilderPage({}),
          '/beliefBuilder': (context) => BeliefBuilderPage({}),
          '/storyBuilder': (context) => StoryBuilderPage({}),
        });
  }
}

class MenuPage extends StatefulWidget {
  final List<Widget> buttons = [
    RouteButton(
        text: 'Story',
        color: Colors.blue,
        image: 'assets/buttons/story.png',
        route: '/storySelection'),
    RouteButton(
        text: 'World Builder',
        color: Colors.green,
        image: 'assets/buttons/world.png',
        route: '/builderSelection'),
    RouteButton(
        text: 'Character Profiler',
        color: Colors.red,
        image: 'assets/buttons/character.png',
        route: '/characterBuilder'),
    RouteButton(
        text: 'Archive',
        color: Colors.orange,
        image: 'assets/buttons/archive.png',
        route: '/archiveSelection'),
    RouteButton(
        text: 'Guides',
        color: Colors.purple,
        image: 'assets/buttons/guides.png',
        route: '/guides'),
    RouteButton(
        text: 'Notes',
        color: Colors.yellow,
        image: 'assets/buttons/notes.png',
        route: '/noteBuilder')
  ];

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
            builder: (context, orientation) => Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: Text('Story Creator',
                          style: TextStyle(fontSize: 48),
                          textAlign: TextAlign.center))),
              Expanded(
                  child: orientation == Orientation.portrait
                      ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                          MediaQuery.of(context).size.width / 8),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: widget.buttons,
                      ))
                      : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                          MediaQuery.of(context).size.width / 20),
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 4,
                                          child: Column(
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .stretch,
                                              children: widget.buttons
                                                  .getRange(0, 3)
                                                  .toList())),
                                      Spacer(),
                                      Expanded(
                                          flex: 4,
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .stretch,
                                              children: widget.buttons
                                                  .getRange(3, 6)
                                                  .toList()))
                                    ]))
                          ])))
            ])));
  }
}
