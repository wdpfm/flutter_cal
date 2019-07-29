import 'package:flutter/material.dart';

import 'cal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static const Color PAGE_COLOR = Color(0xFFFFFFFF);
  static const Color NUM_BTN_BG = Color(0xffff6fc7);
  static const Color TOP_BTN_BG = Color(0xFFCC3299);
  static const Color RIGHT_BTN_BG = Color(0xFFDB7093);
  static const NKeys = [
    "C", "D", "?", "/", //
    "7", "8", "9", "*", //
    "4", "5", "6", "-", //
    "1", "2", "3", "+", //
    "", "0", ".", "=", //
  ];
  static const TKeys = [
    "C",
    "D",
    "?",
  ];
  static const RKeys = ["/", "*", "-", "+", "="];

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _num = '';
  Cal _cal=new Cal();
  void clickKey(String key) {
    _cal.addKey(key);
    setState(() {
      _num=_cal.OutPut;
      //_num += key;
    });
//    if('C'.compareTo(key)==0){
//      _num='';
//      key='';
//    }
//    setState(() {
//      _num += key;
//    });
  }

  @override
  Widget build(BuildContext context) {
    final title = '计算器';
    return new MaterialApp(
      title: title,
      home: new Scaffold(
        backgroundColor: MyApp.PAGE_COLOR,
        appBar: AppBar(
          backgroundColor: MyApp.PAGE_COLOR,
          title: Text(
            '小鸡计算器',
            style: TextStyle(color: Color(0xffff6fc7)),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "$_num",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 32.0,
                          ),
                        )),
                  ),
                )),
                Container(
                  child: _buildBtns(),
                  // buildFlatButton('1'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFlatButton(String num, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          clickKey(num);
        },
        child: Container(
          decoration: BoxDecoration(
              color: MyApp.TKeys.contains(num)
                  ? MyApp.TOP_BTN_BG
                  : MyApp.RKeys.contains(num)
                      ? MyApp.RIGHT_BTN_BG
                      : MyApp.NUM_BTN_BG,
              shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  flex > 1 ? BorderRadius.all(Radius.circular(1000.0)) : null),
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              '$num',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtns() {
    List<Widget> rows = [];
    List<Widget> btns = [];
    int flex = 1;
    for (int i = 0; i < MyApp.NKeys.length; i++) {
      String key = MyApp.NKeys[i];
      if (key.isEmpty) {
        flex++;
        continue;
      } else {
        Widget b = buildFlatButton(key, flex: flex);
        btns.add(b);
        flex = 1;
      }
      if ((i + 1) % 4 == 0) {
        rows.add(Row(
          children: btns,
        ));
        btns = [];
      }
    }
    if (btns.length > 0) {
      rows.add(Row(
        children: btns,
      ));
      btns = [];
    }
    return Column(
      children: rows,
    );
  }
}
