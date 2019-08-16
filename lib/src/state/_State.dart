import "./State.dart";

class ErrorState {
  static const String PermisionDenied =
      "Permission denied, this state does not belong to this component";

  static const String KeyNull = "The key cannot be null";

  static String missPermision(PermisionType type) {
    return "Permision denied, miss this permision " + type.toString();
  }
}

enum PermisionType { Create, Read, Update, Delete }

class StateDom implements State {
  String _masterId;
  String get ID => this._masterId;
  Map<String, dynamic> _initState;
  Map<String, dynamic> _state = {};
  Map<String, dynamic> _oldState = {};
  Map<String, dynamic> get oldState => this._oldState;
  Map<String, dynamic> get state => this._state;
  StateDom(String id, {Map<String, dynamic> initState}) {
    if (initState == null)
      this._initState = {};
    else
      this._initState = initState;

    this._masterId = id;
    this._state = this._initState;
  }

  List<List<String>> _permisionTable = [
    [], // Create
    [], // Read
    [], // update
    [] // delete
  ];

  int _getIndexPermision(PermisionType type) {
    switch (type) {
      case PermisionType.Create:
        return 0;
      case PermisionType.Read:
        return 1;
      case PermisionType.Update:
        return 2;
      case PermisionType.Delete:
        return 3;
      default:
        throw "Error! not exists this type permision";
    }
  }

  _checkState(String id) {
    if (id != this._masterId) throw ErrorState.PermisionDenied;
  }

  List<String> _getListPermision(PermisionType type) {
    int index = this._getIndexPermision(type);
    return this._permisionTable[index];
  }

  bool idInPermision(String id, PermisionType type) {
    var permision = this._getListPermision(type);
    if (this._masterId == id) return true;
    if (permision.indexOf(id) == -1)
      return false;
    else
      return true;
  }

  setPermision(String masterId, {String id, PermisionType type}) {
    this._checkState(masterId);
    int index = this._getIndexPermision(type);
    if (id != null) this._permisionTable[index].add(id);
  }

  revokePermision(String masterId, {String id, PermisionType type}) {
    this._checkState(masterId);
    int index = this._getIndexPermision(type);
    if (id != null) this._permisionTable[index].remove(id);
  }

  dynamic Get(String masterId, String key) {
    if (key == null) {
      throw ErrorState.KeyNull;
    }

    if (this.idInPermision(masterId, PermisionType.Read)) {
      return this._state[key];
    } else {
      throw ErrorState.PermisionDenied;
    }
  }

  Set(String masterId, String key, dynamic value) {
    if (key == null) {
      throw ErrorState.KeyNull;
    }

    this._oldState = Map<String, dynamic>.from(this._state);
    if (this._state.containsKey(key)) {
      // update element
      if (this.idInPermision(masterId, PermisionType.Update)) {
        this._state[key] = value;
      } else {
        throw ErrorState.PermisionDenied;
      }
    } else {
      // create element
      if (this.idInPermision(masterId, PermisionType.Create)) {
        this._state[key] = value;
      } else {
        throw ErrorState.PermisionDenied;
      }
    }
  }

  resetState(String masterId) {
    if (this.idInPermision(masterId, PermisionType.Create)) {
      if (this.idInPermision(masterId, PermisionType.Update))
        this._state = this._initState;
      else {
        throw ErrorState.missPermision(PermisionType.Update);
      }
    } else {
      throw ErrorState.missPermision(PermisionType.Create);
    }
  }

  List<Function(StateDom)> _subs = [];

  notifyAllListener() {
    for (var i in this._subs) {
      i(this);
    }
  }

  addListener(String masterID, Function(StateDom) function) {
    if (this.idInPermision(masterID, PermisionType.Read)) {
      this._subs.add(function);
    } else
      throw ErrorState.PermisionDenied;
  }
}
