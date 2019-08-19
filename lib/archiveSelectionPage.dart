import 'package:flutter/material.dart';

import 'buttons.dart';

class ArchiveSelectionPage extends StatefulWidget {
  final List<Widget> buttons = [
    RouteButton(text: 'World Archive', color: Colors.green, icon: Icons.public, route: '/worldSelection'),
    RouteButton(text: 'Notes Archive', color: Colors.yellow, icon: Icons.edit, route: '/noteSelection'),
    RouteButton(text: 'Technology Archive', color: Colors.blue, icon: Icons.radio, route: '/technologySelection'),
    RouteButton(text: 'Belief Archive', color: Colors.orange, icon: Icons.spa, route: '/beliefSelection'),
    RouteButton(text: 'Magic Archive', color: Colors.purple, icon: Icons.wb_iridescent, route: '/magicSelection'),
    RouteButton(text: 'Character Archive', color: Colors.red, icon: Icons.face, route: '/characterSelection')
  ];

  @override
  _ArchiveSelectionPageState createState() => _ArchiveSelectionPageState();
}

class _ArchiveSelectionPageState extends State<ArchiveSelectionPage> {
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