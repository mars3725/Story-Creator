import 'package:flutter/material.dart';

import 'builders/storyBuilderPage.dart';
import 'main.dart';

class StorySelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StorySelectionPageState();
}

class _StorySelectionPageState extends State<StorySelectionPage> {
  Future<List<Map<String, Object>>> getStories() async =>
      await database.query('stories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed('/storyBuilder')),
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
                        child: Text('Stories',
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center)))
              ])),
          Expanded(
            child: FutureBuilder<List<Map<String, Object>>>(
                future: getStories(),
                builder: (context, snapshot) => snapshot.hasData
                    ? ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => FlatButton(
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StoryBuilderPage(
                                    Map.from(snapshot.data[index])))),
                            child: Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                        (snapshot.data[index]['title'] ?? '') ==
                                                ''.toString().isEmpty
                                            ? snapshot.data[index]['title']
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
