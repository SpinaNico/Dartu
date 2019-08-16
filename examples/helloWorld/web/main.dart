import 'dart:html';

import "package:dartu/dartu.dart";

main() {
  var app = packNodes(Div(child: Center(text: "Hello World!")));

  var root = querySelector("#root");
  if (root != null) {
    root.append(app);
  }
}
