import 'package:dartu/src/state/_State.dart';

import './State.dart';

abstract class ErrorStateComponent {
  static String StateNotInitialized =
      "before using State, initialize state with initState ()";
}

typedef updater = Function(Map<String, dynamic>, Map<String, dynamic>);

class stateComponent implements StateComponent {
  updater _up;
  StateDom _state;
  String _id;
  String get ID => this._id;
  stateComponent(State state, {updater, String id}) {
    this._state = state;
    if (id == null)
      this._id = this._state.ID;
    else
      this._id = id;

    this._up = updater;
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
    var oldState = Map<String, dynamic>.from(this._state.state);

    for (var key in newState.keys) {
      this._state.Set(this._id, key, newState[key]);
    }
    if (this._up != null) this._up(oldState, this._state.state);
  }

  addListener(Function(State) listen) {
    this._state.addListener(this._id, listen);
  }
}
