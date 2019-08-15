import "./State.dart";
import "./_State.dart";
import "./_GlobalState.dart";

class ErrorGlobalState {
  static String notExistState = "does not exist, a state for this key";
  static String stateExistNotOverride =
      "you cannot write an already existing state";
  static String idNotNUll = "ID cannot be null";
}

_addAllPermision(StateDom state, List<String> permisions, PermisionType type) {
  for (var i in permisions) {
    state.setPermision(state.ID, id: i, type: type);
  }
}

GlobalState globalState() => GlobalDomStates();

State createState(
  String id, {
  Map<String, dynamic> initState,
  List<String> idsPermisionOfCreate,
  List<String> idsPermisionOfRead,
  List<String> idsPermisionOfUpdate,
  List<String> idsPermisionOfDelete,
}) {
  var state = StateDom(id, initState: initState);

  if (idsPermisionOfCreate != null) {
    _addAllPermision(state, idsPermisionOfCreate, PermisionType.Create);
  }
  if (idsPermisionOfRead != null) {
    _addAllPermision(state, idsPermisionOfRead, PermisionType.Read);
  }
  if (idsPermisionOfUpdate != null) {
    _addAllPermision(state, idsPermisionOfUpdate, PermisionType.Update);
  }
  if (idsPermisionOfDelete != null) {
    _addAllPermision(state, idsPermisionOfDelete, PermisionType.Delete);
  }

  GlobalDomStates globalDomStates = GlobalDomStates();
  globalDomStates.registerState(id, state);
  return state;
}
