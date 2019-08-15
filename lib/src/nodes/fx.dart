import 'dart:html';
import './Component.dart';
import './core/DomComponent.dart';

HtmlElement packNodes(DomComponent root) {
  if (root is Component) {
    var doms = root.build();
    return doms.pack();
  }
  return root.pack();
}
