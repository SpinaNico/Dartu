import 'package:dartu/src/DomComponent.dart';

setUp(DomComponent domComponent) {
  assert(!(domComponent.child != null && domComponent.children != null),
      "Attention you cannot have both child and children once child: ${domComponent.child} or children:${domComponent.children}");
}
