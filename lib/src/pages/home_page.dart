import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tensor_redux_app/src/pages/word_page.dart';

import 'number_page.dart';

class HomePage extends StatelessWidget {
  static String id = 'home_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Redux Option'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: const Text('Word Lister'),
              onPressed: () {
                Navigator.pushNamed(context, WordPage.id);
              },
            ),
            RaisedButton(
              child: const Text('Number Thing'),
              onPressed: () {
                Navigator.pushNamed(context, NumberPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
