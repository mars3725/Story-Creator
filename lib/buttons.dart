import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({this.color, this.text, this.image, this.route});

  final Color color;
  final String text;
  final String image;
  final String route;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () => Navigator.of(context).pushNamed(this.route),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: this.color,
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Text(this.text,
              style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
          Image.asset(image, height: 50)
        ]));
  }
}

class PDFButton extends StatelessWidget {
  const PDFButton({this.color, this.text, this.image, this.asset});

  final Color color;
  final String text;
  final String image;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FutureBuilder<PDFDocument>(
                future: PDFDocument.fromAsset(this.asset),
                builder: (context, snapshot) => Scaffold(
                    appBar: AppBar(),
                    body: snapshot.hasData
                        ? PDFViewer(document: snapshot.data)
                        : Center(child: CircularProgressIndicator()))))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: this.color,
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Text(this.text,
              style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
          Image.asset(image, height: 50)
        ]));
  }
}
