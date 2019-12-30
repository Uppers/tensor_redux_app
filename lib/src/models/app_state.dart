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
