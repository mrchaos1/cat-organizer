import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/widgets/bottom_sheet_container.dart';
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

    _saveMeal(List<Meal> meals) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.reset();
        _updateResult();
        final Meal meal =  Meal(calories: _resultCalories, datetime: DateTime.now(), description: '${widget.dish.title} - ${_weightController.text}g', eatenDatetime: DateTime.now());
        BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(meal, meals, () {
        }));
        Navigator.of(context).pop();
      }
    }

    return BlocBuilder<MealsListingBloc, MealsListingState>(
      builder: (BuildContext context, state) {
        if (state is MealsListingFetched) {
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(  topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))
            ),
            child: Builder(
                builder: (context) => Form(
                  onChanged: () => setState(() {
                    _updateResult();
                  }),
                  key: _formKey,
                  child: Wrap(
                    children: <Widget>[
                      BottomSheetHeader(
                        child: Text('Devoured ${_resultCalories.toStringAsFixed(2)} kCal', textAlign: TextAlign.center,),
                      ),
                      Container(
                        color: Color(0xFFEEEEEE),
                        child:  TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            suffix: Text('g'),
                            prefix: Text('+'),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some value';
                            }
                            return null;
                          },
                          maxLines: 1,
                          controller: _weightController,
                        ),
                      ),
                      CalcKeyboardWidget(
                        controller: _weightController,
                        onPressed: () => _saveMeal(state.meals)
                      ),
                    ],
                  ),
                )
            ),
          );
        }

        return Container( child: Text('Loading...'), );
      }
    );
  }
}

