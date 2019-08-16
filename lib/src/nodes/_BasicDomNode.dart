import 'dart:html';

import "./core/DomComponent.dart";
import "./_utils.dart";

class BasicDomComponent<T extends HtmlElement> implements DomComponent {
  DomComponent child;
  List<DomComponent> children = [];
  List<String> className = [];
  T element;
  String _tag;
  String text;
  BasicDomComponent(String tag,
      {this.child, this.children, this.className, this.text}) {
    checkDomComponent(this);
    this._tag = tag;
  }

  T pack() {
    this.element = Element.tag(this._tag);

    if (this.className != null) {
      if (!this.className.isEmpty)
        this.element.classes = this.className ?? null;
    }

    if (this.text != null) {
      this.element.text = text;
    }

    if (this.child != null) {
      this.element.append(this.child.pack());
    } else {
      if (this.children != null) {
        for (var i in this.children) {
          this.element.append(i.pack());
        }
      }
    }
    return this.element;
  }
}
