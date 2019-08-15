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
  T element;
  String _tag;
  String text;
  _BasicDomComponent(String tag,
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

class Fragment extends _BasicDomComponent<HtmlElement> {
  Fragment({List<DomComponent> children, DomComponent child})
      : super("<>", child: child, children: children);
}

class SimpeText extends _BasicDomComponent<HtmlElement> {
  SimpeText(String text) : super("text", text: text);
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
