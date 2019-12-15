import 'package:flutter/material.dart';

class CalcKeyboardWidget extends StatelessWidget {
  const CalcKeyboardWidget({ Key key, @required this.controller, this.onPressed }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
//        crossAxisCount: _isPortrait ? 3 : 5,
//        childAspectRatio: _isPortrait ? 2.0 : 3.0,
        crossAxisCount: 3,
        childAspectRatio: 2,
        children: <Widget>[
          GridTile(
            child: InkResponse(
              child: Center(child: Text('+')),
              enableFeedback: true,
              onTap: () =>  controller.text += '+',
            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('*')),
              enableFeedback: true,
              onTap: () =>  controller.text += '*',
            ),
          ),
          GridTile(
            child: InkResponse(
                child: Center(child: Icon(Icons.backspace)),
                enableFeedback: true,
                onTap: () => controller.text = (controller.text == null || controller.text.length == 0)  ? null : (controller.text.substring(0, controller.text.length - 1))
            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('1')),
              enableFeedback: true,
              onTap: () =>  controller.text += '1',
            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('2')),
              enableFeedback: true,
              onTap: () =>  controller.text += '2',

            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('3')),
              enableFeedback: true,
              onTap: () =>  controller.text += '3',

            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('4')),
              enableFeedback: true,
              onTap: () =>  controller.text += '4',

            ),
          ),

          GridTile(
            child: InkResponse(
              child: Center(child: Text('5')),
              enableFeedback: true,
              onTap: () =>  controller.text += '5',

            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('6')),
              enableFeedback: true,
              onTap: () =>  controller.text += '6',

            ),
          ),

          GridTile(
            child: InkResponse(
              child: Center(child: Text('7')),
              enableFeedback: true,
              onTap: () =>  controller.text += '7',

            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('8')),
              enableFeedback: true,
              onTap: () =>  controller.text += '8',

            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('9')),
              enableFeedback: true,
              onTap: () =>  controller.text += '9',

            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('0')),
              enableFeedback: true,
              onTap: () =>  controller.text += '0',
            ),
          ),
          GridTile(
            child: InkResponse(
              child: Center(child: Text('.')),
              enableFeedback: true,
              onTap: () =>  controller.text += '.',
            ),
          ),
          GridTile(
            child: RaisedButton(
                child: Center(child: Text('OK', style: TextStyle(color: Colors.blue))),
                onPressed: () => onPressed(),

//                onPressed: () {
//                  if (_formKey.currentState.validate()) {
//
//                    Expression exp = Parser().parse(_mealController.text);
//                    final double resutValue = exp.evaluate(EvaluationType.REAL, ContextModel());
//                    final Meal meal =  Meal(calories: resutValue, datetime: DateTime.now(), description: 'Test');
//
//                    BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(meal));
//                    _formKey.currentState.reset();
//                  }
//                }
            ),
          ),
        ],
      ),
    );
  }

}
