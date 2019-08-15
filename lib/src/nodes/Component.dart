import 'dart:html';
import './core/DomComponent.dart';
import './_utils.dart';

export "./core/DomComponent.dart";
export './_BasicDomNode.dart' show Span, Div, Center, P;

abstract class Component implements DomComponent {
  DomComponent child;
  List<DomComponent> children;
  HtmlElement pack() {
    checkDomComponent(this);
    return this.build().pack();
  }

  DomComponent build();
}
