import 'package:dartu/src/state/_State.dart';

import './State.dart';

abstract class ErrorStateComponent {
  static String StateNotInitialized =
      "before using State, initialize state with initState ()";
}

class stateComponent implements StateComponent {
  StateDom _state;
  String _id;
  String get ID => this._id;

  stateComponent(State state, {String id}) {
    this._state = state;
    if (id == null)
      this._id = this._state.ID;
    else
      this._id = id;
  }
  @override
  Map<String, dynamic> Get(List<String> keys) {
    if (this._state == null) throw ErrorStateComponent.StateNotInitialized;

    Map<String, dynamic> _semiState = {};

    for (var i in keys) {
      _semiState.addAll({i: this._state.Get(this._id, i)});
    }

    return _semiState;
  }

  @override
  Set(Map<String, dynamic> newState) {
    if (this._state == null) throw ErrorStateComponent.StateNotInitialized;

    for (var key in newState.keys) {
      this._state.Set(this._id, key, newState[key]);
    }

    this._state.notifyAllListener();
  }

  addListener(Function(State) listen) {
    this._state.addListener(this._id, listen);
  }
}
