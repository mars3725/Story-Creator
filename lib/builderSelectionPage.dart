import 'package:flutter/material.dart';

import 'buttons.dart';

class BuilderSelectionPage extends StatefulWidget {
  final List<Widget> buttons = [
    RouteButton(text: 'World Builder', color: Colors.green, icon: Icons.public, route: '/worldBuilder'),
    RouteButton(text: 'Technology Builder', color: Colors.blue, icon: Icons.radio, route: '/technologyBuilder'),
    RouteButton(text: 'Magic Builder', color: Colors.purple, icon: Icons.bubble_chart, route: '/magicBuilder'),
    RouteButton(text: 'Belief Builder', color: Colors.orange, icon: Icons.spa, route: '/beliefBuilder'),
  ];

  @override
  _BuilderSelectionPageState createState() => _BuilderSelectionPageState();
}

class _BuilderSelectionPageState extends State<BuilderSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 50, top: 50),
              child: Align(alignment: Alignment.topLeft,
                  child: GestureDetector(
                      child: Icon(Icons.arrow_back, size: 40), onTap: () => Navigator.of(context).pop()))),
          Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.buttons,
            ),
          )
          )]));
  }
}