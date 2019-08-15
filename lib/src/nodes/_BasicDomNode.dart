import 'dart:html';

import "./core/DomComponent.dart";
import "./_utils.dart";

typedef constructorDomC<T> = T Function(
    {String ID,
    DomComponent child,
    List<DomComponent> childrend,
    String text,
    List<String> className});

class _BasicDomComponent<T extends HtmlElement> implements DomComponent {
  DomComponent child;
  List<DomComponent> children = [];
  List<String> className = [];
  T _element;
  String _tag;
  String text;
  _BasicDomComponent(String tag,
      {this.child, this.children, this.className, this.text}) {
    checkDomComponent(this);
    this._tag = tag;
  }

  T pack() {
    this._element = Element.tag(this._tag);

    if (this.className != null) {
      if (!this.className.isEmpty)
        this._element.classes = this.className ?? null;
    }

    if (this.text != null) {
      this._element.text = text;
    }

    if (this.child != null) {
      this._element.append(this.child.pack());
    } else {
      if (this.children != null) {
        for (var i in this.children) {
          this._element.append(i.pack());
        }
      }
    }
    return this._element;
  }
}

class P extends _BasicDomComponent<ParagraphElement> {
  P({List<DomComponent> children, DomComponent child, String text})
      : super("p", child: child, children: children, text: text);
}

class Div extends _BasicDomComponent<DivElement> {
  Div({List<DomComponent> children, DomComponent child, String text})
      : super("div", child: child, children: children, text: text);
}

class Center extends _BasicDomComponent<HtmlElement> {
  Center({List<DomComponent> children, DomComponent child, String text})
      : super("center", child: child, children: children, text: text);
}

class Span extends _BasicDomComponent<SpanElement> {
  Span({List<DomComponent> children, DomComponent child, String text})
      : super("span", child: child, children: children, text: text);
}
