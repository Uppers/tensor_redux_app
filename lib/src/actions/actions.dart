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
