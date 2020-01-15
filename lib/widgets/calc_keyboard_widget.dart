import 'package:flutter/material.dart';

class CalcKeyboardWidget extends StatelessWidget {


  const CalcKeyboardWidget({ Key key, @required this.controller, this.onPressed }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    final _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: _isPortrait ? 3 : 5,
        childAspectRatio: _isPortrait ? 2.5 : 4.0,
        children: <Widget>[
          KeyboardKeyWidget(Text('+', style: TextStyle(fontSize: 18.0)), () { controller.text += '+'; }),
          KeyboardKeyWidget(Text('*', style: TextStyle(fontSize: 18.0)), () { controller.text += '*'; }),
          KeyboardKeyWidget(Icon(Icons.backspace), () {  controller.text = (controller.text == null || controller.text.length == 0)  ? null : (controller.text.substring(0, controller.text.length - 1)); }),
          KeyboardKeyWidget(Text('1', style: TextStyle(fontSize: 18.0)), () { controller.text += '1'; }),
          KeyboardKeyWidget(Text('2', style: TextStyle(fontSize: 18.0)), () { controller.text += '2'; }),
          KeyboardKeyWidget(Text('3', style: TextStyle(fontSize: 18.0)), () { controller.text += '3'; }),
          KeyboardKeyWidget(Text('4', style: TextStyle(fontSize: 18.0)), () { controller.text += '4'; }),
          KeyboardKeyWidget(Text('5', style: TextStyle(fontSize: 18.0)), () { controller.text += '5'; }),
          KeyboardKeyWidget(Text('6', style: TextStyle(fontSize: 18.0)), () { controller.text += '6'; }),
          KeyboardKeyWidget(Text('7', style: TextStyle(fontSize: 18.0)), () { controller.text += '7'; }),
          KeyboardKeyWidget(Text('8', style: TextStyle(fontSize: 18.0)), () { controller.text += '8'; }),
          KeyboardKeyWidget(Text('9', style: TextStyle(fontSize: 18.0)), () { controller.text += '9'; }),
          KeyboardKeyWidget(Text('0', style: TextStyle(fontSize: 18.0)), () { controller.text += '0'; }),
          KeyboardKeyWidget(Text('.', style: TextStyle(fontSize: 18.0)), () { controller.text += '.'; }),
          KeyboardKeyWidget(Text('OK', style: TextStyle(fontSize: 18.0)), () { onPressed(); }),
        ],
      ),
    );
  }

}


class KeyboardKeyWidget extends StatelessWidget {

  const KeyboardKeyWidget(@required this.child, @required this.onTap);

  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkResponse(
        child: Center(child: child),
        enableFeedback: true,
        onTap: () => onTap(),
//        onTap: () =>  controller.text += '.',
      ),
    );
  }

}