import 'dart:html';

import 'package:dartu/dartu.dart';
import '../DomComponent.dart';

HtmlElement packNodes(DomComponent root) {
  if (root is Component) {
    var doms = root.build();
    return doms.pack();
  }
  return root.pack();
}
