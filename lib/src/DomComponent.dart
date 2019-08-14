import 'dart:html';

abstract class DomComponent {
  DomComponent child = null;
  List<DomComponent> children = null;
  HtmlElement pack();
}
