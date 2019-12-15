import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/widgets/meal_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealActionsModal {

  static Future showModal(BuildContext context, Meal meal) {
    final provider =  BlocProvider.of<MealsListingBloc>(context);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider.value(
              value: provider,
              child: MealActionsWidget(meal: meal)
          );
        }
    );
  }
}