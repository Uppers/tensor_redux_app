import 'package:tensor_redux_app/src/actions/actions.dart';
import 'package:tensor_redux_app/src/models/app_state.dart';

AppState reducer(AppState state, Object action) {
  if (action is AddWordAction) {
    return AppState(
      items: state.items..add(action.input),
      number: state.number,
    );
  } else if (action is RemoveWordAction) {
    return AppState(
      items: state.items..remove(action.item),
      number: state.number,
    );
  } else if (action is RemoveAllAction) {
    return AppState(
      items: <String>[],
      number: state.number,
    );
  } else if (action is PlusOneAction) {
    return AppState(
      items: state.items,
      number: action.number + 1,
    );
  } else if (action is MinusOneAction) {
    return AppState(
      items: state.items,
      number: action.number - 1,
    );
  }
  return AppState(items: state.items, number: state.number);
}
