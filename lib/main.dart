import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppState {
  AppState({this.items});
  AppState.initialState() : items = <String>[];
  final List<String> items;
}

class AddAction {
  AddAction({this.input});
  final String input;
}

class RemoveAction {
  RemoveAction({this.item});
  final String item;
}

class RemoveAllAction {
  // call this to remove all items in list
}

AppState reducer(AppState state, Object action) {
  if (action is AddAction) {
    return AppState(items: state.items..add(action.input));
  } else if (action is RemoveAction) {
    return AppState(items: state.items..remove(action.item));
  } else if (action is RemoveAllAction) {
    return AppState(items: <String>[]);
  }
  return AppState(items: state.items);
}

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
        routes: {
          HomePage.id: (BuildContext context) => HomePage(),
          WordPage.id: (BuildContext context) => WordPage(),
          NumberPage.id: (BuildContext context) => NumberPage(),
        },
      ),
    );
  }
}

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

class NumberPage extends StatelessWidget {
  static String id = 'number_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('0'),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class _ViewModel {
  _ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveAll,
  });

  factory _ViewModel.create(Store<AppState> store) {
    void _onAddItem(String body) {
      store.dispatch(AddAction(input: body));
    }

    void _onRemoveItem(String body) {
      store.dispatch(RemoveAction(item: body));
    }

    void _onRemoveAll() {
      store.dispatch(RemoveAllAction());
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveAll: _onRemoveAll,
    );
  }

  final List<String> items;
  final Function(String) onAddItem;
  final Function(String) onRemoveItem;
  final Function() onRemoveAll;
}

class ListInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel viewModel) {
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
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel viewModel) => Column(
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
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel viewModel) => Container(
        child: RaisedButton(
          child: const Text('Remove All'),
          onPressed: () => viewModel.onRemoveAll(),
        ),
      ),
    );
  }
}
