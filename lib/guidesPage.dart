import 'package:flutter/material.dart';

import 'buttons.dart';

class GuidesPage extends StatefulWidget {
  final List<Widget> buttons = [
    PDFButton(text: 'World Guide', color: Colors.green, icon: Icons.public, asset: 'assets/world.pdf'),
    PDFButton(text: 'Story Guide', color: Colors.blue, icon: Icons.library_books, asset: 'assets/story.pdf'),
    PDFButton(text: 'Technology Guide', color: Colors.yellow, icon: Icons.radio, asset: 'assets/technology.pdf'),
    PDFButton(text: 'Belief Guide', color: Colors.orange, icon: Icons.spa, asset: 'assets/belief.pdf'),
    PDFButton(text: 'Magic Guide', color: Colors.purple, icon: Icons.wb_iridescent, asset: 'assets/magic.pdf'),
    PDFButton(text: 'Character Guide', color: Colors.red, icon: Icons.face, asset: 'assets/character.pdf')
  ];

  @override
  _GuidesPageState createState() => _GuidesPageState();
}

class _GuidesPageState extends State<GuidesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
            builder: (context, orientation) =>
            Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 50, top: 50),
                  child: Align(alignment: Alignment.topLeft,
                      child: GestureDetector(
                          child: Icon(Icons.arrow_back, size: 40), onTap: () => Navigator.of(context).pop()))),
              Expanded(child: orientation == Orientation.portrait
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.buttons,
                ),
              )
                  : Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                        Expanded(flex: 4, child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: widget.buttons.getRange(0, 3).toList())),
                        Spacer(),
                        Expanded(flex: 4, child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: widget.buttons.getRange(3, 6).toList()))
                      ]))
                    ],
                  ))
            )])));
  }
}
