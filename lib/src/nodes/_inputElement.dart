import "./_BasicDomNode.dart";
import "core/DomComponent.dart";
import "dart:html";

class Button extends BasicDomComponent<ButtonElement> {
  Function(Event) onPressed;
  Button(
      {List<DomComponent> children,
      DomComponent child,
      String text,
      this.onPressed})
      : super("button", child: child, children: children, text: text);

  ButtonElement pack() {
    var t = super.pack();
    t.addEventListener("click", this.onPressed);
    return t;
  }
}
