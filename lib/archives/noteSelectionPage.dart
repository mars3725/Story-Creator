import 'package:flutter/material.dart';
import 'package:story_creator/builders/noteBuilderPage.dart';

import '../main.dart';

class NoteSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteSelectionPageState();

}

class _NoteSelectionPageState extends State<NoteSelectionPage> {
  Future<List<Map<String, Object>>> getNotes() async => await database.query('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 50, top: 50, right: 50),
              child: Row(children: <Widget>[
                Align(alignment: Alignment.topLeft,
                    child: GestureDetector(
                        child: Icon(Icons.arrow_back, size: 40), onTap: () => Navigator.of(context).pop())),
                Expanded(child: Center(child: Text('Notes Archive', style: TextStyle(fontSize: 24))))
              ])),
          Expanded(child: FutureBuilder<List<Map<String, Object>>>(future: getNotes(),
                builder: (context, snapshot) => snapshot.hasData?
            ListView.separated(itemCount: snapshot.data.length, itemBuilder: (context, index) => FlatButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteBuilderPage(Map.from(snapshot.data[index]))
                )),
                child: Container(height: 50,
                    child: Center(child: Text((snapshot.data[index]['title'] ?? '') == ''.toString().isEmpty? snapshot.data[index]['title']
                        : 'Unnamed: '+snapshot.data[index]['id'].toString(), style: TextStyle(fontSize: 18))))),
              separatorBuilder: (context, int) => Divider(color: Colors.grey,),
            ) : Center(child: CircularProgressIndicator())),
          )
          ]));
  }
}