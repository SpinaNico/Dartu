import 'dart:html';
import 'package:dartu/src/state/State.dart';
import 'package:dartu/src/state/functionUtilsGlobalState.dart';

import './core/DomComponent.dart';
import './_utils.dart';
export "./core/DomComponent.dart";
export "./_htmlElement.dart";
export './_typography.dart';
export "./_inputElement.dart";
export "./_canvasElement.dart";
export "./_layoutElement.dart";

abstract class Component implements DomComponent {
  DomComponent child;

  List<DomComponent> children;
  StateComponent _stateComponent;
  StateComponent get state => this._stateComponent;
  afterPack() {}
  beforePack() {}
  bool _autoRefresh = false;
  initState() {}

  reBuild() {
    beforePack();
    this._fragment.children = [this.build().pack()];
    afterPack();
  }

  _deepReBuild(State state) {
    this.update(state.oldState, state.state);
    if (this._autoRefresh) {
      this.reBuild();
    }
  }

  List<String> _otherStates = [];
  StateComponent foreignState(String id) {
    if (this._stateComponent == null) {
      throw "You don't have a status, and you can't access other states until you create one -> use createState()";
    }
    var s = ForeignState(this.state.ID, id);
    if (this._otherStates.contains(id) == false) {
      s.addListener((s) {
        this._deepReBuild(s);
      });
      this._otherStates.add(id);
    }
    // print(this._otherStates.toString());
    return s;
  }

  createState(
      {String ID,
      Map<String, dynamic> initState,
      List<String> idsPermisionOfCreate,
      List<String> idsPermisionOfRead,
      List<String> idsPermisionOfUpdate,
      List<String> idsPermisionOfDelete,
      bool autoRefresh: false}) {
    if (this._stateComponent == null) {
      this.initState();

      this._autoRefresh = autoRefresh;
      this._stateComponent = rawCreateState(
        id: ID,
        initState: initState,
        idsPermisionOfCreate: idsPermisionOfCreate,
        idsPermisionOfRead: idsPermisionOfRead,
        idsPermisionOfUpdate: idsPermisionOfUpdate,
        idsPermisionOfDelete: idsPermisionOfDelete,
      );
      this._stateComponent.addListener((s) => this._deepReBuild(s));
    }
  }

  update(Map<String, dynamic> old, Map<String, dynamic> next) {}

  DivElement _fragment = DivElement();
  HtmlElement pack() {
    checkDomComponent(this);
    this.reBuild();
    return this._fragment;
  }

  DomComponent build();
}
