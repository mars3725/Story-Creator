import 'package:flutter/material.dart';

import 'buttons.dart';

class BuilderSelectionPage extends StatefulWidget {
  final List<Widget> buttons = [
    RouteButton(
        text: 'World Builder',
        color: Colors.green,
        image: 'assets/buttons/world.png',
        route: '/worldBuilder'),
    RouteButton(
        text: 'Technology Builder',
        color: Colors.blue,
        image: 'assets/buttons/tech.png',
        route: '/technologyBuilder'),
    RouteButton(
        text: 'Magic Builder',
        color: Colors.purple,
        image: 'assets/buttons/magic.png',
        route: '/magicBuilder'),
    RouteButton(
        text: 'Belief Builder',
        color: Colors.orange,
        image: 'assets/buttons/belief.png',
        route: '/beliefBuilder'),
  ];

  @override
  _BuilderSelectionPageState createState() => _BuilderSelectionPageState();
}

class _BuilderSelectionPageState extends State<BuilderSelectionPage> {
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
                                                  .getRange(0, 2)
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
                                                  .getRange(2, 4)
                                                  .toList()))
                                    ]))
                          ])))
            ])));
  }
}
