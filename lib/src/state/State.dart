import "./_State.dart";

abstract class StateComponent {
  Set(Map<String, dynamic> newState);
  Map<String, dynamic> Get(List<String> keys);
  addListener(Function(State) listen);
  String get ID;
}

abstract class State {
  String get ID;
  Set(String masterId, String key, dynamic value);
  dynamic Get(String masterId, String key);
  Map<String, dynamic> get oldState;
  Map<String, dynamic> get state;
  
  resetState(String masterId);
  setPermision(String masterId, {String id, PermisionType type});
  revokePermision(String masterId, {String id, PermisionType type});
  notifyAllListener();
}

abstract class GlobalState {
  State Get(String id);
  existsState(String id);
}
