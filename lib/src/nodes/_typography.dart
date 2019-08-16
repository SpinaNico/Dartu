import 'dart:html';

import "./_BasicDomNode.dart";
import "./core/DomComponent.dart";

class HR extends BasicDomComponent<HtmlElement> {
  HR() : super("HR");
}

class H1 extends BasicDomComponent<HtmlElement> {
  H1({List<DomComponent> children, DomComponent child, String text})
      : super("h1", child: child, children: children, text: text);
}

class H2 extends BasicDomComponent<HtmlElement> {
  H2({List<DomComponent> children, DomComponent child, String text})
      : super("h2", child: child, children: children, text: text);
}

class H3 extends BasicDomComponent<HtmlElement> {
  H3({List<DomComponent> children, DomComponent child, String text})
      : super("h3", child: child, children: children, text: text);
}

class H4 extends BasicDomComponent<HtmlElement> {
  H4({List<DomComponent> children, DomComponent child, String text})
      : super("h4", child: child, children: children, text: text);
}

class H5 extends BasicDomComponent<HtmlElement> {
  H5({List<DomComponent> children, DomComponent child, String text})
      : super("h5", child: child, children: children, text: text);
}

class H6 extends BasicDomComponent<HtmlElement> {
  H6({List<DomComponent> children, DomComponent child, String text})
      : super("h6", child: child, children: children, text: text);
}

class I extends BasicDomComponent<HtmlElement> {
  I({List<DomComponent> children, DomComponent child, String text})
      : super("i", child: child, children: children, text: text);
}

class B extends BasicDomComponent<HtmlElement> {
  B({List<DomComponent> children, DomComponent child, String text})
      : super("b", child: child, children: children, text: text);
}
