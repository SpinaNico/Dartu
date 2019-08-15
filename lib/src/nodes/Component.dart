import 'dart:html';
import 'package:dartu/src/state/GlobalState.dart';
import 'package:dartu/src/state/_State.dart';

import './core/DomComponent.dart';
import './_utils.dart';
import "../state/State.dart";
export "./core/DomComponent.dart";
export './_BasicDomNode.dart' show Span, Div, Center, P, Fragment, SimpeText;

abstract class ErrorComponent {
  static String StateNotInitialized =
      "before using State, initialize state with initState ()";
}

abstract class Component implements DomComponent {
  DomComponent child;
  DomComponent _this;
  List<DomComponent> children;
  StateDom _stateComponent;
  String _id;
  afterPack() {}
  beforePack() {}

  initState({
    String ID,
    Map<String, dynamic> initState,
    List<String> idsPermisionOfCreate,
    List<String> idsPermisionOfRead,
    List<String> idsPermisionOfUpdate,
    List<String> idsPermisionOfDelete,
  }) {
    this._stateComponent = createState(
        id: ID,
        initState: initState,
        idsPermisionOfCreate: idsPermisionOfCreate,
        idsPermisionOfRead: idsPermisionOfRead,
        idsPermisionOfUpdate: idsPermisionOfUpdate,
        idsPermisionOfDelete: idsPermisionOfDelete);
    this._id = this._stateComponent.ID;
  }

  Set(Map<String, dynamic> newState) {
    if (this._stateComponent == null) throw ErrorComponent.StateNotInitialized;

    for (var key in newState.keys) {
      this._stateComponent.Set(this._id, key, newState[key]);
    }
  }

  Map<String, dynamic> Get(List<String> keys) {
    if (this._stateComponent == null) throw ErrorComponent.StateNotInitialized;

    Map<String, dynamic> _semiState = {};
    for (var i in keys) {
      _semiState.addAll({i: this._stateComponent.Get(this._id, i)});
    }
    return _semiState;
  }

  addStateListener(Function(Map<String, dynamic>) function) {
    var f = (StateDom t) {
      function(t.state);
    };
    this._stateComponent.addListener(this._id, f);
  }

  HtmlElement pack() {
    checkDomComponent(this);
    beforePack();
    this._this = this.build();
    var b = this._this.pack();
    afterPack();
    return b;
  }

  DomComponent build();
}
