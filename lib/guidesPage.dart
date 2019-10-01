import 'package:flutter/material.dart';

import 'buttons.dart';

class GuidesPage extends StatefulWidget {
  final List<Widget> buttons = [
    PDFButton(
        text: 'World Guide',
        color: Colors.green,
        image: 'assets/buttons/world.png',
        asset: 'assets/world.pdf'),
    PDFButton(
        text: 'Story Guide',
        color: Colors.blue,
        image: 'assets/buttons/story.png',
        asset: 'assets/story.pdf'),
    PDFButton(
        text: 'Technology Guide',
        color: Colors.yellow,
        image: 'assets/buttons/tech.png',
        asset: 'assets/technology.pdf'),
    PDFButton(
        text: 'Belief Guide',
        color: Colors.orange,
        image: 'assets/buttons/belief.png',
        asset: 'assets/belief.pdf'),
    PDFButton(
        text: 'Magic Guide',
        color: Colors.purple,
        image: 'assets/buttons/magic.png',
        asset: 'assets/magic.pdf'),
    PDFButton(
        text: 'Character Guide',
        color: Colors.red,
        image: 'assets/buttons/character.png',
        asset: 'assets/character.pdf')
  ];

  @override
  _GuidesPageState createState() => _GuidesPageState();
}

class _GuidesPageState extends State<GuidesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
            builder: (context, orientation) => Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 50, top: 50),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                          child: Icon(Icons.arrow_back, size: 40),
                          onTap: () => Navigator.of(context).pop()))),
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
                    ),
                  )
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
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
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
                                            CrossAxisAlignment.stretch,
                                            children: widget.buttons
                                                .getRange(3, 6)
                                                .toList()))
                                  ]))
                        ],
                      )))
            ])));
  }
}
