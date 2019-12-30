import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppState {
  AppState({
    this.items,
    this.number,
  });
  AppState.initialState()
      : items = <String>[],
        number = 0;
  final List<String> items;
  final int number;
}

class PlusOneAction {
  PlusOneAction({this.number});
  final int number;
}

class MinusOneAction {
  MinusOneAction({this.number});
  final int number;
}

class AddWordAction {
  AddWordAction({this.input});
  final String input;
}

class RemoveWordAction {
  RemoveWordAction({this.item});
  final String item;
}

class RemoveAllAction {
  // call this to remove all items in list
}

AppState reducer(AppState state, Object action) {
  if (action is AddWordAction) {
    return AppState(items: state.items..add(action.input));
  } else if (action is RemoveWordAction) {
    return AppState(items: state.items..remove(action.item));
  } else if (action is RemoveAllAction) {
    return AppState(items: <String>[]);
  } else if (action is PlusOneAction) {
    return AppState(number: action.number + 1);
  } else if (action is MinusOneAction) {
    return AppState(number: action.number - 1);
  }
  return AppState(items: state.items, number: state.number);
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
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
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
    this.number,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveAll,
    this.onPlusOne,
    this.onMinusOne,
  });

  factory _ViewModel.create(Store<AppState> store) {
    void _onAddItem(String body) {
      store.dispatch(AddWordAction(input: body));
    }

    void _onRemoveItem(String body) {
      store.dispatch(RemoveWordAction(item: body));
    }

    void _onRemoveAll() {
      store.dispatch(RemoveAllAction());
    }

    void _onPlusOne(int body) {
      store.dispatch(PlusOneAction(number: body));
    }

    void _onMinusOne(int body) {
      store.dispatch(MinusOneAction(number: body));
    }

    return _ViewModel(
      items: store.state.items,
      number: store.state.number,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveAll: _onRemoveAll,
      onPlusOne: _onPlusOne,
      onMinusOne: _onMinusOne,
    );
  }

  final List<String> items;
  final int number;
  final Function(String) onAddItem;
  final Function(String) onRemoveItem;
  final Function() onRemoveAll;
  final Function(int) onPlusOne;
  final Function(int) onMinusOne;
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
