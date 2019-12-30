import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tensor_redux_app/src/models/app_state.dart';
import 'package:tensor_redux_app/src/models/view_model.dart';

class WordPage extends StatelessWidget {
  static String id = 'word_list_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word List'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ListInput(),
            ViewList(),
            ClearList(),
          ],
        ),
      ),
    );
  }
}

class ListInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return TextField(
          controller: controller,
          onSubmitted: (String text) {
            viewModel.onAddItem(text);
            controller.text = '';
          },
        );
      },
    );
  }
}

class ViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) => Column(
        children: viewModel.items
            .map((String i) => ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => viewModel.onRemoveItem(i),
                ),
                title: Text(i)))
            .toList(),
      ),
    );
  }
}

class ClearList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) => Container(
        child: RaisedButton(
          child: const Text('Remove All'),
          onPressed: () => viewModel.onRemoveAll(),
        ),
      ),
    );
  }
}
