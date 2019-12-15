import 'dart:async';

import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CreateMealWidget extends StatefulWidget {
  CreateMealWidget();
  _CreateMealWidgetState createState() => _CreateMealWidgetState();
}

class _CreateMealWidgetState extends State<CreateMealWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _mealController;
  bool _isPortrait;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _mealController = new TextEditingController();
  }

  @override
  void dispose() {
    _mealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some value';
                    }
                    return null;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  controller: _mealController,
                ),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: _isPortrait ? 3 : 5,
                    childAspectRatio: _isPortrait ? 2.0 : 3.0,
                    children: <Widget>[
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('+')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '+',
                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('*')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '*',
                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                            child: Center(child: Icon(Icons.backspace)),
                            enableFeedback: true,
                            onTap: () => _mealController.text = (_mealController.text == null || _mealController.text.length == 0)  ? null : (_mealController.text.substring(0, _mealController.text.length - 1))
                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('1')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '1',
                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('2')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '2',

                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('3')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '3',

                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('4')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '4',

                        ),
                      ),

                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('5')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '5',

                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('6')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '6',

                        ),
                      ),

                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('7')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '7',

                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('8')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '8',

                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('9')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '9',

                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('0')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '0',
                        ),
                      ),
                      GridTile(
                        child: InkResponse(
                          child: Center(child: Text('.')),
                          enableFeedback: true,
                          onTap: () =>  _mealController.text += '.',
                        ),
                      ),
                      GridTile(
                        child: RaisedButton(
                            child: Center(child: Text('OK', style: TextStyle(color: Colors.blue))),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {

                                Expression exp = Parser().parse(_mealController.text);
                                final double resutValue = exp.evaluate(EvaluationType.REAL, ContextModel());
                                final Meal meal =  Meal(calories: resutValue, datetime: DateTime.now(), description: 'Test');

                                BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(meal));
                                _formKey.currentState.reset();
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

