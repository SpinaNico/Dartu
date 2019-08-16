import "./_BasicDomNode.dart";
import "core/DomComponent.dart";
import "dart:html";

class SimpeText extends BasicDomComponent<HtmlElement> {
  SimpeText(String text) : super("text", text: text);
}

class P extends BasicDomComponent<ParagraphElement> {
  P({List<DomComponent> children, DomComponent child, String text})
      : super("p", child: child, children: children, text: text);
}

class Div extends BasicDomComponent<DivElement> {
  Div({List<DomComponent> children, DomComponent child, String text})
      : super("div", child: child, children: children, text: text);
}

class Center extends BasicDomComponent<HtmlElement> {
  Center({List<DomComponent> children, DomComponent child, String text})
      : super("center", child: child, children: children, text: text);
}

class Span extends BasicDomComponent<SpanElement> {
  Span({List<DomComponent> children, DomComponent child, String text})
      : super("span", child: child, children: children, text: text);
}
