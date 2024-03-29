import 'package:flutter/material.dart';
import 'package:story_creator/builders/characterBuilderPage.dart';

import '../main.dart';

class CharacterSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  Future<List<Map<String, Object>>> getCharacters() async =>
      await database.query('characters');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed('/characterBuilder')),
        body: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 50, top: 50, right: 50),
              child: Row(children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        child: Icon(Icons.arrow_back, size: 40),
                        onTap: () => Navigator.of(context).pop())),
                Expanded(
                    child: Center(
                        child: Text('Character Archive',
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center)))
              ])),
          Expanded(
            child: FutureBuilder<List<Map<String, Object>>>(
                future: getCharacters(),
                builder: (context, snapshot) => snapshot.hasData
                    ? ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => FlatButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CharacterBuilderPage(
                                  Map.from(snapshot.data[index])))),
                      child: Container(
                          height: 50,
                          child: Center(
                              child: Text(
                                  !["", null, false, 0].contains(snapshot.data[index]['name'])
                                      ? snapshot.data[index]['name']
                                      : 'Unnamed: ' +
                                      snapshot.data[index]['id'].toString(),
                                  style: TextStyle(fontSize: 18))))),
                  separatorBuilder: (context, int) => Divider(
                    color: Colors.grey,
                  ),
                )
                    : Center(child: CircularProgressIndicator())),
          )
        ]));
  }
}
