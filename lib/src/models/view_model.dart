import 'package:redux/redux.dart';
import 'package:tensor_redux_app/src/actions/actions.dart';
import 'app_state.dart';

class ViewModel {
  ViewModel({
    this.items,
    this.number,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveAll,
    this.onPlusOne,
    this.onMinusOne,
  });

  factory ViewModel.create(Store<AppState> store) {
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

    return ViewModel(
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
