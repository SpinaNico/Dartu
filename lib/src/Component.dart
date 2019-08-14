import 'dart:html';

import 'package:dartu/dartu.dart';
import 'package:dartu/src/DomComponent.dart';
import 'package:dartu/src/core/_utils.dart';

abstract class Component implements DomComponent {
  DomComponent child;
  List<DomComponent> children;
  HtmlElement pack() {
    setUp(this);
    return this.build().pack();
  }

  DomComponent build();
}
