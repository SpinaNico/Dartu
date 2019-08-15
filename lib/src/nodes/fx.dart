import 'dart:html';
import './Component.dart';
import './core/DomComponent.dart';

HtmlElement packNodes(DomComponent root) {
  if (root is Component) {
    root.beforePack();
    var doms = root.build().pack();
    root.afterPack();
    return doms;
  }
  return root.pack();
}
