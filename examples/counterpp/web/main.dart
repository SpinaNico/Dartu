import 'dart:html';

import "package:dartu/dartu.dart";

main() {
  var app = packNodes(Div(child: CounterPP()));

  var root = querySelector("#root");
  if (root != null) {
    root.append(app);
  }
}

class BoxEven extends Component {
  beforePack() {
    this.createState(ID: "Counter++", autoRefresh: true);
  }

  @override
  DomComponent build() {
    int even = this.state.Get(["evenSum"])["evenSum"];
    return Div(text: "Sum even number: $even");
  }
}

class BoxOdd extends Component {
  beforePack() {
    this.createState(ID: "Counter++", autoRefresh: true);
  }

  @override
  DomComponent build() {
    int odd = this.state.Get(["oddSum"])["oddSum"];
    return Div(text: "Sum  odd number: $odd");
  }
}

class CounterPP extends Component {
  @override
  beforePack() {
    this.createState(
        ID: "Counter++",
        initState: {"count": 0, "oddSum": 0, "evenSum": 0},
        autoRefresh: false);
  }

  update(oldState, newState) {
    print("$oldState $newState");
  }

  @override
  DomComponent build() {
    int c = this.state.Get(["count"])["count"];
    return Center(children: [
      H2(text: "Counter++"),
      Div(children: [BoxOdd(), BoxEven()]),
      HR(),
      Button(
          text: "Push me!",
          onPressed: (e) {
            ++c;
            var s = this.state.Get(["evenSum", "oddSum"]);
            if (c % 2 == 0) {
              s["evenSum"] += c;
            } else {
              s["oddSum"] += c;
            }
            this.state.Set(
                {"count": c, "evenSum": s["evenSum"], "oddSum": s["oddSum"]});
          })
    ]);
  }
}
