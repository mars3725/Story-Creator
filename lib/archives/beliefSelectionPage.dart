import 'package:flutter/material.dart';
import 'package:story_creator/builders/beliefBuilderPage.dart';

import '../main.dart';

class BeliefSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BeliefSelectionPageState();
}

class _BeliefSelectionPageState extends State<BeliefSelectionPage> {
  Future<List<Map<String, Object>>> getBeliefs() async => await database.query('beliefs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(left: 50, top: 50, right: 50),
          child: Row(children: <Widget>[
            Align(alignment: Alignment.topLeft, child: GestureDetector(child: Icon(Icons.arrow_back, size: 40), onTap: () => Navigator.of(context).pop())),
            Expanded(child: Center(child: Text('Belief Archive', style: TextStyle(fontSize: 24))))
          ])),
      Expanded(
        child: FutureBuilder<List<Map<String, Object>>>(
            future: getBeliefs(),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => FlatButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BeliefBuilderPage(Map.from(snapshot.data[index])))),
                        child: Container(
                            height: 50, child: Center(child: Text((snapshot.data[index]['name'] ?? '') == ''.toString().isEmpty ? 'Unnamed: ' + snapshot.data[index]['id'].toString() : snapshot.data[index]['name'], style: TextStyle(fontSize: 18))))),
                    separatorBuilder: (context, int) => Divider(
                      color: Colors.grey,
                    ),
                  )
                : Center(child: CircularProgressIndicator())),
      )
    ]));
  }
}