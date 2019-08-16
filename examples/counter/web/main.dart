import 'dart:html';

import "package:dartu/dartu.dart";

main() {
  var app = packNodes(Div(child: Counter()));

  var root = querySelector("#root");
  if (root != null) {
    root.append(app);
  }
}

class Counter extends Component {
  @override
  beforePack() {
    this.createState(initState: {"count": 0}, autoRefresh: true);
  }

  @override
  DomComponent build() {
    int c = this.state.Get(["count"])["count"];
    return Center(children: [
      H2(text: "Simply counter"),
      P(child: B(text: c.toString())),
      HR(),
      Button(
          text: "Push me!",
          onPressed: (e) {
            c = c + 1;
            this.state.Set({"count": c++});
          })
    ]);
  }
}
