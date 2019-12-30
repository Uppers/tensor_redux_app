import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tensor_redux_app/src/models/app_state.dart';
import 'package:tensor_redux_app/src/pages/home_page.dart';
import 'package:tensor_redux_app/src/reducer/reducer.dart';

import 'src/pages/number_page.dart';
import 'src/pages/word_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store =
      Store<AppState>(reducer, initialState: AppState.initialState());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Demo',
        theme: ThemeData.dark(),
        initialRoute: HomePage.id,
        routes: <String, Widget Function(BuildContext)>{
          HomePage.id: (BuildContext context) => HomePage(),
          WordPage.id: (BuildContext context) => WordPage(),
          NumberPage.id: (BuildContext context) => NumberPage(),
        },
      ),
    );
  }
}
