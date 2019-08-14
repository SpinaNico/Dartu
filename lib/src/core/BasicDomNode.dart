import 'dart:html';

import "../DomComponent.dart";
import "./_utils.dart";

class P implements DomComponent {
  String text;
  DomComponent child;
  List<DomComponent> children;

  P({this.text, this.child, this.children}) {
    setUp(this);
  }
  @override
  HtmlElement pack() {
    var c = ParagraphElement();
    c.text = this.text;
    return c;
  }

  @override
  String toString() {
    return "P[${this.text}]";
  }
}

class Div implements DomComponent {
  DomComponent child;
  List<DomComponent> children;
  List<String> _className = [];
  Div({this.child, this.children, List<String> className}) {
    setUp(this);
    if (className != null) this._className = className;
  }

  DivElement pack() {
    var c = new DivElement();
    if (!this._className.isEmpty) c.classes = this._className ?? null;
    if (this.child != null) {
      c.append(this.child.pack());
    } else {
      if (this.children != null) {
        for (var i in this.children) {
          c.append(i.pack());
        }
      }
    }
    return c;
  }
}
