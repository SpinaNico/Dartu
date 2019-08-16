import 'dart:html';

import "./_BasicDomNode.dart";
import "./core/DomComponent.dart";

class Column extends BasicDomComponent<DivElement> {
  Column({List<DomComponent> children}) : super("div", children: children);

  DivElement pack() {
    var t = super.pack();
    t.style.display = "grid";
    t.style.gridTemplateColumns = "repeat(auto-fill, 100px)";
    return t;
  }
}

class Row extends BasicDomComponent<DivElement> {
  Row({List<DomComponent> children}) : super("div", children: children);

  DivElement pack() {
    var t = super.pack();
    t.style.display = "grid";
    t.style.gridTemplateRows = "repeat(auto-fill, 100px)";
    return t;
  }
}
