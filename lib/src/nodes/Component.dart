import 'dart:html';
import 'package:dartu/src/state/State.dart';
import 'package:dartu/src/state/functionUtilsGlobalState.dart';

import './core/DomComponent.dart';
import './_utils.dart';
export "./core/DomComponent.dart";
export './_BasicDomNode.dart' show Span, Div, Center, P, SimpeText, Button;

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

  StateComponent foreignState(String id) {
    if (this._stateComponent == null) {
      throw "You don't have a status, and you can't access other states until you create one -> use createState()";
    }
    return ForeignState(this.state.ID, id);
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
          functionUpdate: this.update);
      this._stateComponent.addListener((state) {
        if (this._autoRefresh) {
          this.reBuild();
        }
      });
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
