import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMealPage extends StatefulWidget {
  EditMealPage({
    Key key, this.meal
  }) : super(key: key);

  final Meal meal;

  @override
  _EditMealPageState createState() => _EditMealPageState();
}

class _EditMealPageState extends State<EditMealPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _caloriesController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  final _caloriesFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _caloriesController.text = widget.meal.calories == null ? '' : widget.meal.calories.toString();
    _descriptionController.text = widget.meal.description;
  }

  _saveMeal(List<Meal> meals) {
    if (_formKey.currentState.validate()) {
      widget.meal.calories = double.parse(_caloriesController.text);
      widget.meal.description = _descriptionController.text;
      widget.meal.datetime = DateTime.now();

      if (widget.meal.isEaten == true) {
        widget.meal.eatenDatetime = DateTime.now();
      }

      BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(widget.meal, meals, () {
        Navigator.of(context).pop();
      }));

      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MealsListingBloc, MealsListingState>(
      builder: (BuildContext context, state) {
        if (state is MealsListingFetched) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit meal'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () => _saveMeal(state.meals),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Builder(
                  builder: (BuildContext context) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[

                          CheckboxListTile(
                            title: Align(
                              child: Text('Is eaten'),
                              alignment: Alignment(-1.15, 0),
                            ),
                            value: widget.meal.isEaten == true,
                            onChanged: (bool result) {
                              setState(() {
                                widget.meal.isEaten = result;
                              });
                            },
                          ),

                          TextFormField(
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(
                                    _descriptionFocus),
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            focusNode: _caloriesFocus,
                            decoration: InputDecoration(
                                labelText: 'Calories'
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            controller: _caloriesController,
                          ),

                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            onEditingComplete: () => _saveMeal(state.meals),
                            textInputAction: TextInputAction.next,
                            focusNode: _descriptionFocus,
                            decoration: InputDecoration(
                                labelText: 'Description'
                            ),
                            maxLines: null,
                            controller: _descriptionController,
                          ),


                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.blue,
                              child: Text('Save', style: TextStyle(
                                  color: Colors.white)),
                              onPressed: () async {
                                _saveMeal(state.meals);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          );

        }


        return Container( child: Text('Loading...'), );


      }
    );


  }
}