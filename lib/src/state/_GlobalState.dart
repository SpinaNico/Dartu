import "./GlobalState.dart";
import "./State.dart";
import "./_State.dart";
import 'dart:math';

class GlobalDomStates implements GlobalState {
  GlobalDomStates._internal();
  static GlobalDomStates _globalDomStates = GlobalDomStates._internal();
  factory GlobalDomStates() => GlobalDomStates._globalDomStates;

  Map<String, StateDom> _state = {};

  State _getStateWithId(String id) {
    return this._state[id];
  }

  static String getRandomID() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 10; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  registerState(String id, State state) {
    if (id == null) {
      throw ErrorGlobalState.idNotNUll;
    }
    if (this._state.containsKey(id)) {
      StateDom c = this._getStateWithId(id);
      if (c.idInPermision(id, PermisionType.Delete)) {
        this._state[id] = state;
      } else {
        throw ErrorGlobalState.stateExistNotOverride;
      }
    } else {
      this._state[id] = state;
    }
  }

  State Get(String id) {
    if (this._state.containsKey(id)) {
      StateDom c = this._state[id];
      if (c.idInPermision(id, PermisionType.Read)) {
        return c;
      } else {
        throw ErrorState.PermisionDenied;
      }
    } else {
      throw ErrorGlobalState.notExistState;
    }
  }
}
