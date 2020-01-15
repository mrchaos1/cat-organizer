import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreateDishPage extends StatefulWidget {
  CreateDishPage({
    Key key, this.customDish
  }) : super(key: key);

  final CustomDish customDish;

  @override
  _CreateDishPageState createState() => _CreateDishPageState();
}

class _CreateDishPageState extends State<CreateDishPage> {
  final _formKey = GlobalKey<FormState>();

  CustomDish _dish;

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _panWeightController = new TextEditingController();
  TextEditingController _caloriesController = new TextEditingController();

  final _titleNode = FocusNode();
  final _weightNode = FocusNode();
  final _panWeightNode = FocusNode();
  final _caloriesNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _dish = widget.customDish;


    if (_dish.id == null) {
      _dish = CustomDish(calories: 0, weight: 0, panWeight: 0, title: '');
      _titleController.text = '';
      _weightController.text = '';
      _panWeightController.text = '';
      _caloriesController.text = '';
    } else {
      _titleController.text = _dish.title;
      _weightController.text = _dish.weight.toString();
      _panWeightController.text = _dish.panWeight.toString();
      _caloriesController.text = _dish.calories.toString();
    }

  }

  Future<CustomDish> _saveDish() async {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<CustomDishListingBloc>(context).add(CustomDishCreatingEvent(_dish));
      Navigator.of(context).pop();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Dish has been saved!')));
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Edit custom dish'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => _saveDish(),
            ),
          ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Builder(
            builder: (context) => Form(
              onChanged: () =>  setState(() {
                _dish.title = _titleController.text;
                _dish.panWeight = _panWeightController.text.isEmpty ? 0 : double.parse(_panWeightController.text);
                _dish.weight = _weightController.text.isEmpty ? 0 : double.parse(_weightController.text);
                _dish.calories = _caloriesController.text.isEmpty ? 0 : double.parse(_caloriesController.text);
              }),

              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_caloriesNode),
                    textInputAction: TextInputAction.next,
                    focusNode: _titleNode,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        labelText: 'Dish title'
                    ),
                    maxLines: null,
                    controller: _titleController,
                  ),

                  TextFormField(
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_weightNode),
                    textInputAction: TextInputAction.next,
                    focusNode: _caloriesNode,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        labelText: 'Dish calories'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter dish calorie content';
                      }
                      return null;
                    },
                    maxLines: null,
                    keyboardType: TextInputType.number,
                    controller: _caloriesController,
                  ),

                  TextFormField(
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_panWeightNode),
                    textInputAction: TextInputAction.next,
                    focusNode: _weightNode,
                    decoration: InputDecoration(
                        labelText: 'Dish weight'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter dish weight';
                      }
                      return null;
                    },
                    maxLines: null,
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                  ),

                  TextFormField(
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _saveDish(),
                    focusNode: _panWeightNode,
                    decoration: InputDecoration(
                      labelText: 'Pan weight',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter pan weight';
                      }
                      return null;
                    },
                    maxLines: null,
                    keyboardType: TextInputType.number,
                    controller: _panWeightController,
                  ),

                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: Text('${_dish.getCalorieContent()}kCal / 100g', style: TextStyle(fontSize: 20.0, color: Colors.pinkAccent),)
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                      onPressed: () => _saveDish(),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}