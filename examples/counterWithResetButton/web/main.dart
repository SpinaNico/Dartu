import 'dart:async';
import 'dart:html';
import "package:dartu/dartu.dart";

void main() {
  HtmlElement app = packNodes(Div(child: MyApp()));

  var root = querySelector("#root");
  if (app != null) {
    root.append(app);
  }
}

class MyPersonalButton extends Component {
  Function(Event) onPressed;
  int count;
  beforePack() {
    this.createState(ID: "StateApp", autoRefresh: true);
  }

  MyPersonalButton({this.onPressed});
  DomComponent build() {
    int c = this.state.Get(["count"])["count"];
    return Button(
        text: "Reset ($c)",
        onPressed: (e) {
          this.state.Set({"count": 0});
        });
  }
}

class MyApp extends Component {
  initState() {
    Timer.periodic(Duration(seconds: 1), (t) {
      int c = this.state.Get(["count"])["count"];
      c++;
      this.state.Set({"count": c});
    });
  }

  beforePack() {
    this.createState(
        ID: "StateApp", initState: {"count": 0}, autoRefresh: true);
  }

  DomComponent build() {
    var count = this.state.Get(["count"])["count"];
    return Center(children: [P(text: count.toString()), MyPersonalButton()]);
  }
}
