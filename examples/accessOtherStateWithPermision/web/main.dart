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
  StateComponent _otherState;
  beforePack() {
    this.createState(ID: "button1");
    this._otherState = this.foreignState("StateApp");
  }

  MyPersonalButton({this.onPressed});
  DomComponent build() {
    return Button(
        text: "Reset ",
        onPressed: (e) {
          this._otherState.Set({"count": 0});
          print(this.state.ID);
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
        ID: "StateApp",
        initState: {"count": 0},
        autoRefresh: true,
        idsPermisionOfUpdate: ["button1"]);
  }

  DomComponent build() {
    var count = this.state.Get(["count"])["count"];
    return Center(children: [P(text: count.toString()), MyPersonalButton()]);
  }
}
