import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/widgets/calc_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CustomDishGobbleUpWidget extends StatefulWidget {
  CustomDishGobbleUpWidget(this.dish);
  final CustomDish dish;
  _CustomDishGobbleUpWidgetState createState() => _CustomDishGobbleUpWidgetState();
}

class _CustomDishGobbleUpWidgetState extends State<CustomDishGobbleUpWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _weightController;
  double _resultCalories = 0;
  bool _isPortrait;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _weightController = new TextEditingController();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void _updateResult() {
      try {
        Expression exp = Parser().parse(_weightController.text);
        final double resutValue = exp.evaluate(EvaluationType.REAL, ContextModel());
        _resultCalories = (resutValue / 100) * widget.dish.getCalorieContent();
      } on Error catch (e) {
        _resultCalories = 0;
      }
    }

    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Builder(
        builder: (context) => Form(
          onChanged: () => setState(() {
            _updateResult();
          }),
          key: _formKey,
          child: Column(
            children: <Widget>[

              Text('Devoured ${_resultCalories.toStringAsFixed(2)}kCal'),

              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
                maxLines: null,
                keyboardType: TextInputType.number,
                controller: _weightController,
              ),
              CalcKeyboardWidget(
                controller: _weightController,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _updateResult();
                    final Meal meal =  Meal(calories: _resultCalories, datetime: DateTime.now(), description: widget.dish.title);

                    BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(meal));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}

