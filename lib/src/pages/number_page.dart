import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tensor_redux_app/src/models/app_state.dart';
import 'package:tensor_redux_app/src/models/view_model.dart';

class NumberPage extends StatelessWidget {
  static String id = 'number_page';
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: const Text('Number Page'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('${viewModel.number}'),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => viewModel.onPlusOne(viewModel.number),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => viewModel.onMinusOne(viewModel.number),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
